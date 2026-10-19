/// Domain model for custom personal AAC cards (people, objects, places, etc.).
library;

import 'aac_button.dart';

/// Predefined standard personal categories.
abstract final class PersonalCardCategory {
  static const family = 'family';
  static const friends = 'friends';
  static const caregivers = 'caregivers';
  static const things = 'things';
  static const food = 'food';
  static const activities = 'activities';
  static const places = 'places';
  static const feelings = 'feelings';
  static const actions = 'actions';
  static const custom = 'custom';

  static const all = [
    family,
    friends,
    caregivers,
    things,
    food,
    activities,
    places,
    feelings,
    actions,
    custom,
  ];
}

/// Standard personal board IDs.
abstract final class PersonalBoardId {
  static const myFamily = 'my_family';
  static const myFriends = 'my_friends';
  static const myThings = 'my_things';
  static const myFavoriteFood = 'my_favorite_food';
  static const myPlaces = 'my_places';
  static const myActivities = 'my_activities';

  static const all = [
    myFamily,
    myFriends,
    myThings,
    myFavoriteFood,
    myPlaces,
    myActivities,
  ];
}

class PersonalCard {
  const PersonalCard({
    required this.id,
    required this.profileId,
    required this.name,
    this.speechText = '',
    required this.category,
    required this.imageUri,
    this.labelsByLocale = const {},
    this.speechByLocale = const {},
    this.boardIds = const [],
    this.isFavorite = false,
    this.sortOrder = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Unique immutable identifier.
  final String id;

  /// Profile ownership to ensure strict isolation across profiles.
  final String profileId;

  /// Primary display label (e.g., "Mama", "Water Bottle").
  final String name;

  /// Spoken TTS text when activated. Falls back to [name] if empty.
  final String speechText;

  /// Category tag for Fitzgerald color coding and organization.
  final String category;

  /// URI to the image: absolute local file path, `data:image/...` URI, or bundled symbol.
  final String imageUri;

  /// Localized labels for multilingual display (`ar`, `ar-DZ`, `de`, `en`).
  final Map<String, String> labelsByLocale;

  /// Localized spoken text for multilingual speech output (`ar`, `ar-DZ`, `de`, `en`).
  final Map<String, String> speechByLocale;

  /// Assigned personal boards (e.g. `['my_family']`).
  final List<String> boardIds;

  /// When true, surfaces directly in the main home Favourites strip.
  final bool isFavorite;

  /// Deterministic position order index to ensure stable motor planning.
  final int sortOrder;

  final DateTime createdAt;
  final DateTime updatedAt;

  /// Resolves the label for a given language code (fallback to primary [name]).
  String labelFor(String languageCode) {
    final direct = labelsByLocale[languageCode];
    if (direct != null && direct.isNotEmpty) return direct;
    final normalized = languageCode.replaceAll('-', '_');
    final normMatch = labelsByLocale[normalized];
    if (normMatch != null && normMatch.isNotEmpty) return normMatch;
    final base = languageCode.split(RegExp('[-_]')).first;
    final baseMatch = labelsByLocale[base];
    if (baseMatch != null && baseMatch.isNotEmpty) return baseMatch;
    return name;
  }

  /// Resolves the voice-out text for a given language code (fallback to [speechText] or [name]).
  String speechFor(String languageCode) {
    final direct = speechByLocale[languageCode];
    if (direct != null && direct.isNotEmpty) return direct;
    final normalized = languageCode.replaceAll('-', '_');
    final normMatch = speechByLocale[normalized];
    if (normMatch != null && normMatch.isNotEmpty) return normMatch;
    final base = languageCode.split(RegExp('[-_]')).first;
    final baseMatch = speechByLocale[base];
    if (baseMatch != null && baseMatch.isNotEmpty) return baseMatch;
    return speechText.isNotEmpty ? speechText : labelFor(languageCode);
  }

  /// Converts this personal card into an [AACButton] for grid rendering and utterance.
  AACButton toAacButton({Position? position}) {
    return AACButton(
      id: id,
      label: name,
      labelByLocale: labelsByLocale,
      type: AACButtonType.word,
      position: position ?? (row: 0, col: 0),
      category: category,
      baseWeight: 0.9, // High clinical priority for user's personal items
      iconUri: imageUri,
      voiceOut: speechText.isNotEmpty ? speechText : name,
      voiceOutByLocale: speechByLocale,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'profile_id': profileId,
        'name': name,
        'speech_text': speechText,
        'category': category,
        'image_uri': imageUri,
        'labels_by_locale': labelsByLocale,
        'speech_by_locale': speechByLocale,
        'board_ids': boardIds,
        'is_favorite': isFavorite,
        'sort_order': sortOrder,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory PersonalCard.fromJson(Map<String, dynamic> json) {
    return PersonalCard(
      id: json['id'] as String,
      profileId: json['profile_id'] as String? ?? 'default',
      name: json['name'] as String? ?? '',
      speechText: json['speech_text'] as String? ?? '',
      category: json['category'] as String? ?? PersonalCardCategory.custom,
      imageUri: json['image_uri'] as String? ?? '',
      labelsByLocale: (json['labels_by_locale'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(k, v.toString()),
          ) ??
          const {},
      speechByLocale: (json['speech_by_locale'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(k, v.toString()),
          ) ??
          const {},
      boardIds: (json['board_ids'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      isFavorite: json['is_favorite'] as bool? ?? false,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  PersonalCard copyWith({
    String? id,
    String? profileId,
    String? name,
    String? speechText,
    String? category,
    String? imageUri,
    Map<String, String>? labelsByLocale,
    Map<String, String>? speechByLocale,
    List<String>? boardIds,
    bool? isFavorite,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PersonalCard(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      speechText: speechText ?? this.speechText,
      category: category ?? this.category,
      imageUri: imageUri ?? this.imageUri,
      labelsByLocale: labelsByLocale ?? this.labelsByLocale,
      speechByLocale: speechByLocale ?? this.speechByLocale,
      boardIds: boardIds ?? this.boardIds,
      isFavorite: isFavorite ?? this.isFavorite,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
