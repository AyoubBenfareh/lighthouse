// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Noor Quest';

  @override
  String get appTitleArabic => 'مغامرات نور';

  @override
  String get tagline => 'Play, Explore, and Learn';

  @override
  String get splashTagline => 'An adventure of light and learning';

  @override
  String get chooseLanguage => 'Choose your language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get continueLabel => 'Continue';

  @override
  String get createProfile => 'Create your adventurer';

  @override
  String get pickAvatar => 'Pick an avatar';

  @override
  String get adventurerName => 'Adventurer name (optional)';

  @override
  String get nameHint => 'Noor Friend';

  @override
  String get startAdventure => 'Start adventure';

  @override
  String welcomeHome(String name) {
    return 'Welcome, $name!';
  }

  @override
  String starsCount(int count) {
    return '$count stars';
  }

  @override
  String xpCount(int count) {
    return '$count XP';
  }

  @override
  String get play => 'Play';

  @override
  String get openMap => 'Open world map';

  @override
  String get achievements => 'Achievements';

  @override
  String get parentArea => 'Parent area';

  @override
  String get noorGreeting =>
      'Hi! I\'m Noor, your glowing lantern friend. Let\'s explore!';

  @override
  String get worldMapTitle => 'Adventure Map';

  @override
  String get worldArabic => 'Alphabet Island';

  @override
  String get worldPrayer => 'Prayer City';

  @override
  String get worldGarden => 'Garden of Islam';

  @override
  String get worldManners => 'Manners Village';

  @override
  String get worldQuran => 'Quran Oasis';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get locked => 'Locked';

  @override
  String get playGame => 'Play';

  @override
  String get back => 'Back';

  @override
  String get home => 'Home';

  @override
  String get next => 'Next';

  @override
  String get retry => 'Try again';

  @override
  String get greatJob => 'Great job!';

  @override
  String get almost => 'Almost — try again!';

  @override
  String get correct => 'Correct!';

  @override
  String get victoryTitle => 'You did it!';

  @override
  String starsEarned(int count) {
    return 'You earned $count stars';
  }

  @override
  String xpEarned(int count) {
    return '+$count XP';
  }

  @override
  String get backToMap => 'Back to map';

  @override
  String get playAgain => 'Play again';

  @override
  String get arabicLettersTitle => 'Letter Adventure';

  @override
  String get arabicLettersHint => 'Which letter does this start with?';

  @override
  String get hearWord => 'Hear word';

  @override
  String get hearLetter => 'Hear letter';

  @override
  String get wuduTitle => 'Wudu Challenge';

  @override
  String get wuduHint => 'Put the wudu steps in the right order';

  @override
  String get wuduCheck => 'Check order';

  @override
  String get wuduExplanation =>
      'This is a learning activity using a commonly taught introductory sequence. Schools of thought may differ on details. Always ask a trusted teacher for religious guidance.';

  @override
  String get mannersTitle => 'Good Manners';

  @override
  String get mannersHint => 'What would you do?';

  @override
  String get parentGateTitle => 'Parents only';

  @override
  String parentGatePrompt(int a, int b) {
    return 'What is $a + $b?';
  }

  @override
  String get parentGateWrong => 'Not quite — ask a parent to help.';

  @override
  String get parentGatePin => 'Or enter parent PIN';

  @override
  String get parentPinHint => '4-digit PIN';

  @override
  String get parentSetPin => 'Set parent PIN';

  @override
  String get parentClearPin => 'Clear PIN';

  @override
  String get parentProgress => 'Progress overview';

  @override
  String get parentLanguage => 'App language';

  @override
  String get parentAudio => 'Speak words aloud';

  @override
  String get parentSfxVolume => 'Sound effects volume';

  @override
  String get parentReducedMotion => 'Reduce animations';

  @override
  String get parentReset => 'Reset all progress';

  @override
  String get parentResetConfirm =>
      'Erase stars, XP, unlocks, and badges? This cannot be undone.';

  @override
  String get parentCancel => 'Cancel';

  @override
  String get parentConfirm => 'Reset';

  @override
  String get parentReminders => 'Session reminders (local only)';

  @override
  String get parentRemindersHint =>
      'Gentle local reminders — no accounts, no cloud.';

  @override
  String get parentExternalLinks => 'External links';

  @override
  String get parentPrivacyNote =>
      'Noor Quest is offline-first. No child accounts, ads, or tracking in this MVP.';

  @override
  String get badgeFirstStar => 'First Star';

  @override
  String get badgeLetterLearner => 'Letter Learner';

  @override
  String get badgeWuduExplorer => 'Wudu Explorer';

  @override
  String get badgeKindHeart => 'Kind Heart';

  @override
  String get badgeMapTraveler => 'Map Traveler';

  @override
  String get badgeStarCollector => 'Star Collector';

  @override
  String get badgeGardenFriend => 'Garden Friend';

  @override
  String get noBadgesYet => 'Complete activities to earn badges!';

  @override
  String roundOf(int current, int total) {
    return 'Round $current of $total';
  }

  @override
  String get lessonComplete => 'Lesson complete!';

  @override
  String get starsAreRewards =>
      'Stars are educational rewards — not spiritual merit.';

  @override
  String get skip => 'Skip';

  @override
  String get avatarExplorer => 'Explorer';

  @override
  String get avatarDesertFox => 'Desert Fox';

  @override
  String get avatarBird => 'Sky Bird';

  @override
  String get avatarCat => 'Kind Cat';

  @override
  String get avatarStarKid => 'Star Kid';

  @override
  String get avatarGardenExplorer => 'Garden Friend';

  @override
  String get arabicPathTitle => 'Alphabet Path';

  @override
  String get arabicPathHint => 'Learn letters step by step';

  @override
  String stageLabel(int n) {
    return 'Stage $n';
  }

  @override
  String get traceHint => 'Trace the letter with your finger';

  @override
  String get gardenTitle => 'Garden of Islam';

  @override
  String get gardenHint => 'Learn the five pillars gently';

  @override
  String get pillarShahada => 'Faith';

  @override
  String get pillarPrayer => 'Prayer';

  @override
  String get pillarCharity => 'Charity';

  @override
  String get pillarFasting => 'Fasting';

  @override
  String get pillarHajj => 'Pilgrimage';

  @override
  String get teacherTitle => 'Noor Teacher';

  @override
  String get teacherHint => 'Offline tips from Noor';

  @override
  String get teacherOfflineOnly =>
      'Curated offline lessons — cloud AI is disabled.';

  @override
  String get premiumTitle => 'Family+';

  @override
  String get premiumBody =>
      'Family+ unlocks future extras. Purchases are not enabled in this build.';

  @override
  String get premiumBlocked =>
      'In-app purchases require store credentials and owner approval.';

  @override
  String get adsDisabled => 'Ads stay off for children.';

  @override
  String get aiDisabled => 'Cloud AI requires approval and is disabled.';

  @override
  String get accountScaffold =>
      'Parent accounts are optional scaffolding — continue offline anytime.';

  @override
  String get alreadyClaimed => 'Rewards already collected for this lesson.';

  @override
  String get routeError => 'Something went wrong with navigation.';

  @override
  String get completedLabel => 'Completed';

  @override
  String get unlockedLabel => 'Unlocked';

  @override
  String get badgesLabel => 'Badges';

  @override
  String get selectWorld => 'Tap an island to explore';

  @override
  String get privacyNicknameOnly => 'No personal info needed — nickname only.';
}
