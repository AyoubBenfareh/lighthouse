// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Noor Quest';

  @override
  String get appTitleArabic => 'مغامرات نور';

  @override
  String get splashTagline => 'Ein Abenteuer aus Licht und Lernen';

  @override
  String get chooseLanguage => 'Wähle deine Sprache';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get continueLabel => 'Weiter';

  @override
  String get createProfile => 'Erstelle deinen Abenteurer';

  @override
  String get pickAvatar => 'Wähle einen Avatar';

  @override
  String get adventurerName => 'Abenteurername (optional)';

  @override
  String get nameHint => 'Noor Freund';

  @override
  String get startAdventure => 'Abenteuer starten';

  @override
  String welcomeHome(String name) {
    return 'Willkommen, $name!';
  }

  @override
  String starsCount(int count) {
    return '$count Sterne';
  }

  @override
  String xpCount(int count) {
    return '$count XP';
  }

  @override
  String get play => 'Spielen';

  @override
  String get openMap => 'Weltkarte öffnen';

  @override
  String get achievements => 'Erfolge';

  @override
  String get parentArea => 'Elternbereich';

  @override
  String get noorGreeting =>
      'Hallo! Ich bin Noor, deine leuchtende Laternenfreundin. Lass uns entdecken!';

  @override
  String get worldMapTitle => 'Abenteuerkarte';

  @override
  String get worldArabic => 'Insel des arabischen Alphabets';

  @override
  String get worldPrayer => 'Gebetsstadt';

  @override
  String get worldGarden => 'Garten des Islam';

  @override
  String get worldManners => 'Dorf der guten Manieren';

  @override
  String get worldQuran => 'Koran-Oase';

  @override
  String get comingSoon => 'Demnächst';

  @override
  String get locked => 'Gesperrt';

  @override
  String get playGame => 'Spielen';

  @override
  String get back => 'Zurück';

  @override
  String get home => 'Start';

  @override
  String get next => 'Weiter';

  @override
  String get retry => 'Nochmal versuchen';

  @override
  String get greatJob => 'Super gemacht!';

  @override
  String get almost => 'Fast — versuch es nochmal!';

  @override
  String get correct => 'Richtig!';

  @override
  String get victoryTitle => 'Geschafft!';

  @override
  String starsEarned(int count) {
    return 'Du hast $count Sterne verdient';
  }

  @override
  String xpEarned(int count) {
    return '+$count XP';
  }

  @override
  String get backToMap => 'Zurück zur Karte';

  @override
  String get playAgain => 'Nochmal spielen';

  @override
  String get arabicLettersTitle => 'Arabisches Buchstabenabenteuer';

  @override
  String get arabicLettersHint => 'Mit welchem Buchstaben beginnt das?';

  @override
  String get hearWord => 'Wort anhören';

  @override
  String get wuduTitle => 'Wudu-Reihenfolge';

  @override
  String get wuduHint => 'Ordne die Wudu-Schritte richtig';

  @override
  String get wuduCheck => 'Reihenfolge prüfen';

  @override
  String get wuduExplanation =>
      'Dies ist eine Lernaktivität mit einer häufig gelehrten Einführungssequenz. Rechtsschulen können in Details abweichen. Frage eine vertrauenswürdige Lehrperson für religiöse Orientierung.';

  @override
  String get mannersTitle => 'Abenteuer guter Manieren';

  @override
  String get mannersHint => 'Was würdest du tun?';

  @override
  String get parentGateTitle => 'Nur für Eltern';

  @override
  String parentGatePrompt(int a, int b) {
    return 'Was ist $a + $b?';
  }

  @override
  String get parentGateWrong => 'Nicht ganz — bitte einen Elternteil um Hilfe.';

  @override
  String get parentProgress => 'Fortschrittsübersicht';

  @override
  String get parentLanguage => 'App-Sprache';

  @override
  String get parentAudio => 'Wörter laut aussprechen';

  @override
  String get parentReducedMotion => 'Animationen reduzieren';

  @override
  String get parentReset => 'Gesamten Fortschritt zurücksetzen';

  @override
  String get parentResetConfirm =>
      'Sterne, XP, Freischaltungen und Abzeichen löschen? Das kann nicht rückgängig gemacht werden.';

  @override
  String get parentCancel => 'Abbrechen';

  @override
  String get parentConfirm => 'Zurücksetzen';

  @override
  String get parentReminders => 'Sitzungserinnerungen (nur lokal)';

  @override
  String get parentRemindersHint =>
      'Sanfte lokale Erinnerungen — keine Konten, keine Cloud.';

  @override
  String get parentExternalLinks => 'Externe Links';

  @override
  String get parentPrivacyNote =>
      'Noor Quest ist offline-first. Keine Kinderkonten, Werbung oder Tracking in diesem MVP.';

  @override
  String get badgeFirstStar => 'Erster Stern';

  @override
  String get badgeLetterLearner => 'Buchstabenlerner';

  @override
  String get badgeWuduExplorer => 'Wudu-Entdecker';

  @override
  String get badgeKindHeart => 'Gutes Herz';

  @override
  String get badgeMapTraveler => 'Kartenreisender';

  @override
  String get badgeStarCollector => 'Sternensammler';

  @override
  String get noBadgesYet =>
      'Schließe Aktivitäten ab, um Abzeichen zu verdienen!';

  @override
  String roundOf(int current, int total) {
    return 'Runde $current von $total';
  }

  @override
  String get lessonComplete => 'Lektion abgeschlossen!';

  @override
  String get starsAreRewards =>
      'Sterne sind Lernbelohnungen — kein spirituelles Verdienst.';

  @override
  String get skip => 'Überspringen';
}
