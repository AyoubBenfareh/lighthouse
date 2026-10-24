import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Noor Quest'**
  String get appTitle;

  /// No description provided for @appTitleArabic.
  ///
  /// In en, this message translates to:
  /// **'مغامرات نور'**
  String get appTitleArabic;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'An adventure of light and learning'**
  String get splashTagline;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguage;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get languageGerman;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @createProfile.
  ///
  /// In en, this message translates to:
  /// **'Create your adventurer'**
  String get createProfile;

  /// No description provided for @pickAvatar.
  ///
  /// In en, this message translates to:
  /// **'Pick an avatar'**
  String get pickAvatar;

  /// No description provided for @adventurerName.
  ///
  /// In en, this message translates to:
  /// **'Adventurer name (optional)'**
  String get adventurerName;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Noor Friend'**
  String get nameHint;

  /// No description provided for @startAdventure.
  ///
  /// In en, this message translates to:
  /// **'Start adventure'**
  String get startAdventure;

  /// No description provided for @welcomeHome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcomeHome(String name);

  /// No description provided for @starsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} stars'**
  String starsCount(int count);

  /// No description provided for @xpCount.
  ///
  /// In en, this message translates to:
  /// **'{count} XP'**
  String xpCount(int count);

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @openMap.
  ///
  /// In en, this message translates to:
  /// **'Open world map'**
  String get openMap;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @parentArea.
  ///
  /// In en, this message translates to:
  /// **'Parent area'**
  String get parentArea;

  /// No description provided for @noorGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi! I\'m Noor, your glowing lantern friend. Let\'s explore!'**
  String get noorGreeting;

  /// No description provided for @worldMapTitle.
  ///
  /// In en, this message translates to:
  /// **'Adventure Map'**
  String get worldMapTitle;

  /// No description provided for @worldArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic Alphabet Island'**
  String get worldArabic;

  /// No description provided for @worldPrayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer City'**
  String get worldPrayer;

  /// No description provided for @worldGarden.
  ///
  /// In en, this message translates to:
  /// **'Garden of Islam'**
  String get worldGarden;

  /// No description provided for @worldManners.
  ///
  /// In en, this message translates to:
  /// **'Village of Good Manners'**
  String get worldManners;

  /// No description provided for @worldQuran.
  ///
  /// In en, this message translates to:
  /// **'Quran Oasis'**
  String get worldQuran;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @playGame.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get playGame;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @greatJob.
  ///
  /// In en, this message translates to:
  /// **'Great job!'**
  String get greatJob;

  /// No description provided for @almost.
  ///
  /// In en, this message translates to:
  /// **'Almost — try again!'**
  String get almost;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// No description provided for @victoryTitle.
  ///
  /// In en, this message translates to:
  /// **'You did it!'**
  String get victoryTitle;

  /// No description provided for @starsEarned.
  ///
  /// In en, this message translates to:
  /// **'You earned {count} stars'**
  String starsEarned(int count);

  /// No description provided for @xpEarned.
  ///
  /// In en, this message translates to:
  /// **'+{count} XP'**
  String xpEarned(int count);

  /// No description provided for @backToMap.
  ///
  /// In en, this message translates to:
  /// **'Back to map'**
  String get backToMap;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play again'**
  String get playAgain;

  /// No description provided for @arabicLettersTitle.
  ///
  /// In en, this message translates to:
  /// **'Arabic Letter Adventure'**
  String get arabicLettersTitle;

  /// No description provided for @arabicLettersHint.
  ///
  /// In en, this message translates to:
  /// **'Which letter does this start with?'**
  String get arabicLettersHint;

  /// No description provided for @hearWord.
  ///
  /// In en, this message translates to:
  /// **'Hear word'**
  String get hearWord;

  /// No description provided for @wuduTitle.
  ///
  /// In en, this message translates to:
  /// **'Wudu Sequence Challenge'**
  String get wuduTitle;

  /// No description provided for @wuduHint.
  ///
  /// In en, this message translates to:
  /// **'Put the wudu steps in the right order'**
  String get wuduHint;

  /// No description provided for @wuduCheck.
  ///
  /// In en, this message translates to:
  /// **'Check order'**
  String get wuduCheck;

  /// No description provided for @wuduExplanation.
  ///
  /// In en, this message translates to:
  /// **'This is a learning activity using a commonly taught introductory sequence. Schools of thought may differ on details. Always ask a trusted teacher for religious guidance.'**
  String get wuduExplanation;

  /// No description provided for @mannersTitle.
  ///
  /// In en, this message translates to:
  /// **'Good Manners Adventure'**
  String get mannersTitle;

  /// No description provided for @mannersHint.
  ///
  /// In en, this message translates to:
  /// **'What would you do?'**
  String get mannersHint;

  /// No description provided for @parentGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Parents only'**
  String get parentGateTitle;

  /// No description provided for @parentGatePrompt.
  ///
  /// In en, this message translates to:
  /// **'What is {a} + {b}?'**
  String parentGatePrompt(int a, int b);

  /// No description provided for @parentGateWrong.
  ///
  /// In en, this message translates to:
  /// **'Not quite — ask a parent to help.'**
  String get parentGateWrong;

  /// No description provided for @parentProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress overview'**
  String get parentProgress;

  /// No description provided for @parentLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get parentLanguage;

  /// No description provided for @parentAudio.
  ///
  /// In en, this message translates to:
  /// **'Speak words aloud'**
  String get parentAudio;

  /// No description provided for @parentReducedMotion.
  ///
  /// In en, this message translates to:
  /// **'Reduce animations'**
  String get parentReducedMotion;

  /// No description provided for @parentReset.
  ///
  /// In en, this message translates to:
  /// **'Reset all progress'**
  String get parentReset;

  /// No description provided for @parentResetConfirm.
  ///
  /// In en, this message translates to:
  /// **'Erase stars, XP, unlocks, and badges? This cannot be undone.'**
  String get parentResetConfirm;

  /// No description provided for @parentCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get parentCancel;

  /// No description provided for @parentConfirm.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get parentConfirm;

  /// No description provided for @parentReminders.
  ///
  /// In en, this message translates to:
  /// **'Session reminders (local only)'**
  String get parentReminders;

  /// No description provided for @parentRemindersHint.
  ///
  /// In en, this message translates to:
  /// **'Gentle local reminders — no accounts, no cloud.'**
  String get parentRemindersHint;

  /// No description provided for @parentExternalLinks.
  ///
  /// In en, this message translates to:
  /// **'External links'**
  String get parentExternalLinks;

  /// No description provided for @parentPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'Noor Quest is offline-first. No child accounts, ads, or tracking in this MVP.'**
  String get parentPrivacyNote;

  /// No description provided for @badgeFirstStar.
  ///
  /// In en, this message translates to:
  /// **'First Star'**
  String get badgeFirstStar;

  /// No description provided for @badgeLetterLearner.
  ///
  /// In en, this message translates to:
  /// **'Letter Learner'**
  String get badgeLetterLearner;

  /// No description provided for @badgeWuduExplorer.
  ///
  /// In en, this message translates to:
  /// **'Wudu Explorer'**
  String get badgeWuduExplorer;

  /// No description provided for @badgeKindHeart.
  ///
  /// In en, this message translates to:
  /// **'Kind Heart'**
  String get badgeKindHeart;

  /// No description provided for @badgeMapTraveler.
  ///
  /// In en, this message translates to:
  /// **'Map Traveler'**
  String get badgeMapTraveler;

  /// No description provided for @badgeStarCollector.
  ///
  /// In en, this message translates to:
  /// **'Star Collector'**
  String get badgeStarCollector;

  /// No description provided for @noBadgesYet.
  ///
  /// In en, this message translates to:
  /// **'Complete activities to earn badges!'**
  String get noBadgesYet;

  /// No description provided for @roundOf.
  ///
  /// In en, this message translates to:
  /// **'Round {current} of {total}'**
  String roundOf(int current, int total);

  /// No description provided for @lessonComplete.
  ///
  /// In en, this message translates to:
  /// **'Lesson complete!'**
  String get lessonComplete;

  /// No description provided for @starsAreRewards.
  ///
  /// In en, this message translates to:
  /// **'Stars are educational rewards — not spiritual merit.'**
  String get starsAreRewards;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
