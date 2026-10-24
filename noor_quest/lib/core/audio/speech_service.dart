import 'package:flutter_tts/flutter_tts.dart';

/// Optional on-device speech. Letter/vocab learning audio is always Arabic.
class SpeechService {
  SpeechService() : _tts = FlutterTts();

  final FlutterTts _tts;
  bool _ready = false;

  Future<void> init() async {
    try {
      await _tts.setSpeechRate(0.40);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.05);
      _ready = true;
    } catch (_) {
      _ready = false;
    }
  }

  Future<void> speakUi(String text, {required String localeCode}) async {
    if (!_ready || text.trim().isEmpty) return;
    try {
      final lang = switch (localeCode) {
        'ar' => 'ar',
        'de' => 'de-DE',
        _ => 'en-US',
      };
      await _tts.setLanguage(lang);
      await _tts.speak(text);
    } catch (_) {}
  }

  /// Always Arabic — independent of UI language.
  Future<void> speakArabicLearning(String arabicText) async {
    if (!_ready || arabicText.trim().isEmpty) return;
    try {
      await _tts.setLanguage('ar');
      await _tts.speak(arabicText);
    } catch (_) {
      // Graceful degrade when Arabic voice pack missing.
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {}
  }
}
