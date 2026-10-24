import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Non-musical SFX only — no background music, instruments, or melodies.
enum Sfx {
  tap,
  correct,
  incorrect,
  star,
  xp,
  unlock,
  drag,
  transition,
  celebrate,
  achievement,
}

class SoundManager {
  SoundManager();

  final AudioPlayer _player = AudioPlayer();
  bool enabled = true;
  double volume = 0.8;
  bool _ready = false;

  static const _assets = {
    Sfx.tap: 'sfx/tap.wav',
    Sfx.correct: 'sfx/correct.wav',
    Sfx.incorrect: 'sfx/incorrect.wav',
    Sfx.star: 'sfx/star.wav',
    Sfx.xp: 'sfx/xp.wav',
    Sfx.unlock: 'sfx/unlock.wav',
    Sfx.drag: 'sfx/drag.wav',
    Sfx.transition: 'sfx/transition.wav',
    Sfx.celebrate: 'sfx/celebrate.wav',
    Sfx.achievement: 'sfx/achievement.wav',
  };

  Future<void> init() async {
    try {
      await _player.setReleaseMode(ReleaseMode.stop);
      await _player.setVolume(volume);
      _ready = true;
    } catch (e) {
      debugPrint('SoundManager init failed: $e');
      _ready = false;
    }
  }

  Future<void> play(Sfx sfx) async {
    if (!enabled || !_ready) return;
    final asset = _assets[sfx];
    if (asset == null) return;
    try {
      await _player.stop();
      await _player.setVolume(volume.clamp(0, 1));
      await _player.play(AssetSource(asset));
    } catch (e) {
      debugPrint('SFX play failed ($sfx): $e');
    }
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
