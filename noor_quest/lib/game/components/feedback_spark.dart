import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Lightweight Flame spark used for correct-answer feedback.
class FeedbackSpark extends CircleComponent {
  FeedbackSpark({required Vector2 position})
      : super(
          position: position,
          radius: 10,
          anchor: Anchor.center,
          paint: Paint()..color = AppColors.warmGold,
        ) {
    add(
      SequenceEffect([
        ScaleEffect.by(Vector2.all(2.2), EffectController(duration: 0.25)),
        RemoveEffect(),
      ]),
    );
  }
}
