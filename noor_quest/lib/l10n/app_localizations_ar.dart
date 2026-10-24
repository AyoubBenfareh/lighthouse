// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مغامرات نور';

  @override
  String get appTitleArabic => 'مغامرات نور';

  @override
  String get tagline => 'العب، اكتشف، وتعلّم';

  @override
  String get splashTagline => 'مغامرة نورٍ وتعلّم';

  @override
  String get chooseLanguage => 'اختر لغتك';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get continueLabel => 'متابعة';

  @override
  String get createProfile => 'أنشئ مغامرك';

  @override
  String get pickAvatar => 'اختر صورة رمزية';

  @override
  String get adventurerName => 'اسم المغامر (اختياري)';

  @override
  String get nameHint => 'صديق نور';

  @override
  String get startAdventure => 'ابدأ المغامرة';

  @override
  String welcomeHome(String name) {
    return 'مرحبًا، $name!';
  }

  @override
  String starsCount(int count) {
    return '$count نجوم';
  }

  @override
  String xpCount(int count) {
    return '$count نقطة خبرة';
  }

  @override
  String get play => 'العب';

  @override
  String get openMap => 'افتح خريطة العالم';

  @override
  String get achievements => 'الإنجازات';

  @override
  String get parentArea => 'منطقة الوالدين';

  @override
  String get noorGreeting => 'مرحبًا! أنا نور، فانوسك المتوهج. هيا نستكشف!';

  @override
  String get worldMapTitle => 'خريطة المغامرة';

  @override
  String get worldArabic => 'جزيرة الحروف';

  @override
  String get worldPrayer => 'مدينة الصلاة';

  @override
  String get worldGarden => 'حديقة الإسلام';

  @override
  String get worldManners => 'قرية الأخلاق';

  @override
  String get worldQuran => 'واحة القرآن';

  @override
  String get comingSoon => 'قريبًا';

  @override
  String get locked => 'مقفلة';

  @override
  String get playGame => 'العب';

  @override
  String get back => 'رجوع';

  @override
  String get home => 'الرئيسية';

  @override
  String get next => 'التالي';

  @override
  String get retry => 'حاول مرة أخرى';

  @override
  String get greatJob => 'أحسنت!';

  @override
  String get almost => 'تقريبًا — حاول مرة أخرى!';

  @override
  String get correct => 'صحيح!';

  @override
  String get victoryTitle => 'لقد نجحت!';

  @override
  String starsEarned(int count) {
    return 'حصلت على $count نجوم';
  }

  @override
  String xpEarned(int count) {
    return '+$count نقطة خبرة';
  }

  @override
  String get backToMap => 'العودة للخريطة';

  @override
  String get playAgain => 'العب مرة أخرى';

  @override
  String get arabicLettersTitle => 'مغامرة الحروف';

  @override
  String get arabicLettersHint => 'بأي حرف تبدأ هذه الكلمة؟';

  @override
  String get hearWord => 'استمع للكلمة';

  @override
  String get hearLetter => 'استمع للحرف';

  @override
  String get wuduTitle => 'تحدي الوضوء';

  @override
  String get wuduHint => 'رتّب خطوات الوضوء بالترتيب الصحيح';

  @override
  String get wuduCheck => 'تحقق من الترتيب';

  @override
  String get wuduExplanation =>
      'هذا نشاط تعليمي يستخدم تسلسلًا تمهيديًا شائع التدريس. قد تختلف المذاهب في التفاصيل. اسأل معلمًا موثوقًا للإرشاد الديني.';

  @override
  String get mannersTitle => 'الأخلاق الحسنة';

  @override
  String get mannersHint => 'ماذا تفعل؟';

  @override
  String get parentGateTitle => 'للوالدين فقط';

  @override
  String parentGatePrompt(int a, int b) {
    return 'كم يساوي $a + $b؟';
  }

  @override
  String get parentGateWrong => 'ليس تمامًا — اطلب مساعدة أحد الوالدين.';

  @override
  String get parentGatePin => 'أو أدخل رمز الوالدين';

  @override
  String get parentPinHint => 'رمز من 4 أرقام';

  @override
  String get parentSetPin => 'تعيين رمز الوالدين';

  @override
  String get parentClearPin => 'مسح الرمز';

  @override
  String get parentProgress => 'نظرة على التقدّم';

  @override
  String get parentLanguage => 'لغة التطبيق';

  @override
  String get parentAudio => 'نطق الكلمات بصوت عالٍ';

  @override
  String get parentSfxVolume => 'مستوى المؤثرات الصوتية';

  @override
  String get parentReducedMotion => 'تقليل الحركة';

  @override
  String get parentReset => 'إعادة ضبط كل التقدّم';

  @override
  String get parentResetConfirm =>
      'محو النجوم ونقاط الخبرة والفتح والشارات؟ لا يمكن التراجع.';

  @override
  String get parentCancel => 'إلغاء';

  @override
  String get parentConfirm => 'إعادة ضبط';

  @override
  String get parentReminders => 'تذكيرات الجلسة (محلية فقط)';

  @override
  String get parentRemindersHint =>
      'تذكيرات محلية لطيفة — بلا حسابات وبلا سحابة.';

  @override
  String get parentExternalLinks => 'روابط خارجية';

  @override
  String get parentPrivacyNote =>
      'مغامرات نور تعمل دون اتصال. لا حسابات أطفال ولا إعلانات ولا تتبّع في هذا الإصدار.';

  @override
  String get badgeFirstStar => 'النجمة الأولى';

  @override
  String get badgeLetterLearner => 'متعلّم الحروف';

  @override
  String get badgeWuduExplorer => 'مستكشف الوضوء';

  @override
  String get badgeKindHeart => 'قلب طيب';

  @override
  String get badgeMapTraveler => 'رحّالة الخريطة';

  @override
  String get badgeStarCollector => 'جامع النجوم';

  @override
  String get badgeGardenFriend => 'صديق الحديقة';

  @override
  String get noBadgesYet => 'أكمل الأنشطة لكسب الشارات!';

  @override
  String roundOf(int current, int total) {
    return 'الجولة $current من $total';
  }

  @override
  String get lessonComplete => 'اكتمل الدرس!';

  @override
  String get starsAreRewards => 'النجوم مكافآت تعليمية — وليست أجرًا روحيًا.';

  @override
  String get skip => 'تخطي';

  @override
  String get avatarExplorer => 'المستكشف';

  @override
  String get avatarDesertFox => 'ثعلب الصحراء';

  @override
  String get avatarBird => 'طائر السماء';

  @override
  String get avatarCat => 'القط اللطيف';

  @override
  String get avatarStarKid => 'طفل النجمة';

  @override
  String get avatarGardenExplorer => 'صديق الحديقة';

  @override
  String get arabicPathTitle => 'مسار الحروف';

  @override
  String get arabicPathHint => 'تعلّم الحروف خطوة بخطوة';

  @override
  String stageLabel(int n) {
    return 'المرحلة $n';
  }

  @override
  String get traceHint => 'تتبّع الحرف بإصبعك';

  @override
  String get gardenTitle => 'حديقة الإسلام';

  @override
  String get gardenHint => 'تعرّف على أركان الإسلام بلطف';

  @override
  String get pillarShahada => 'الشهادة';

  @override
  String get pillarPrayer => 'الصلاة';

  @override
  String get pillarCharity => 'الزكاة';

  @override
  String get pillarFasting => 'الصيام';

  @override
  String get pillarHajj => 'الحج';

  @override
  String get teacherTitle => 'معلّم نور';

  @override
  String get teacherHint => 'نصائح من نور دون اتصال';

  @override
  String get teacherOfflineOnly =>
      'دروس مختارة دون اتصال — الذكاء السحابي معطّل.';

  @override
  String get premiumTitle => 'عائلي+';

  @override
  String get premiumBody =>
      'عائلي+ يفتح ميزات مستقبلية. الشراء غير مفعّل في هذا الإصدار.';

  @override
  String get premiumBlocked =>
      'المشتريات داخل التطبيق تحتاج اعتماد المتجر وموافقة المالك.';

  @override
  String get adsDisabled => 'الإعلانات معطّلة للأطفال.';

  @override
  String get aiDisabled => 'الذكاء السحابي يحتاج موافقة وهو معطّل.';

  @override
  String get accountScaffold =>
      'حسابات الوالدين اختيارية — يمكن المتابعة دون اتصال دائمًا.';

  @override
  String get alreadyClaimed => 'تم جمع مكافآت هذا الدرس مسبقًا.';

  @override
  String get routeError => 'حدث خطأ في التنقّل.';

  @override
  String get completedLabel => 'مكتمل';

  @override
  String get unlockedLabel => 'مفتوح';

  @override
  String get badgesLabel => 'الشارات';

  @override
  String get selectWorld => 'اضغط على جزيرة للاستكشاف';

  @override
  String get privacyNicknameOnly => 'لا حاجة لمعلومات شخصية — لقب فقط.';
}
