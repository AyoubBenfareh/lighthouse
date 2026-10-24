import 'package:flutter_tts/flutter_tts.dart';

/// Optional on-device speech for ordinary vocabulary — degrades gracefully.
class SpeechService {
  SpeechService() : _tts = FlutterTts();

  final FlutterTts _tts;
  bool _ready = false;

  Future<void> init() async {
    try {
      await _tts.setSpeechRate(0.42);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.05);
      _ready = true;
    } catch (_) {
      _ready = false;
    }
  }

  Future<void> speak(String text, {required String localeCode}) async {
    if (!_ready || text.trim().isEmpty) return;
    try {
      final lang = switch (localeCode) {
        'ar' => 'ar',
        'de' => 'de-DE',
        _ => 'en-US',
      };
      await _tts.setLanguage(lang);
      await _tts.speak(text);
    } catch (_) {
      // Graceful degrade — no speech available.
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {}
  }
}
