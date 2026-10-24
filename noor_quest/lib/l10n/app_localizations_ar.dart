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
  String get arabicLettersTitle => 'مغامرة الحروف العربية';

  @override
  String get arabicLettersHint => 'بأي حرف تبدأ هذه الكلمة؟';

  @override
  String get hearWord => 'استمع للكلمة';

  @override
  String get wuduTitle => 'تحدي ترتيب الوضوء';

  @override
  String get wuduHint => 'رتّب خطوات الوضوء بالترتيب الصحيح';

  @override
  String get wuduCheck => 'تحقق من الترتيب';

  @override
  String get wuduExplanation =>
      'هذا نشاط تعليمي يستخدم تسلسلًا تمهيديًا شائع التدريس. قد تختلف المذاهب في التفاصيل. اسأل معلمًا موثوقًا للإرشاد الديني.';

  @override
  String get mannersTitle => 'مغامرة الأخلاق الحسنة';

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
  String get parentProgress => 'نظرة على التقدّم';

  @override
  String get parentLanguage => 'لغة التطبيق';

  @override
  String get parentAudio => 'نطق الكلمات بصوت عالٍ';

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
}
