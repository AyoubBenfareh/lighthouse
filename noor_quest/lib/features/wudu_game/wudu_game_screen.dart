import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/star_burst.dart';
import '../../data/lessons/lesson_catalog.dart';
import '../../data/models/lesson_models.dart';
import '../victory/victory_screen.dart';

class WuduGameScreen extends ConsumerStatefulWidget {
  const WuduGameScreen({super.key});

  @override
  ConsumerState<WuduGameScreen> createState() => _WuduGameScreenState();
}

class _WuduGameScreenState extends ConsumerState<WuduGameScreen> {
  late List<WuduStep> _slots;
  String? _feedback;
  bool _checked = false;

  static const _icons = <String, IconData>{
    'heart': Icons.favorite_rounded,
    'hands': Icons.back_hand_rounded,
    'face': Icons.sentiment_satisfied_alt_rounded,
    'face_wash': Icons.face_retouching_natural,
    'arms': Icons.accessibility_new_rounded,
    'head': Icons.spa_rounded,
    'feet': Icons.directions_walk_rounded,
  };

  @override
  void initState() {
    super.initState();
    _slots = List.of(LessonCatalog.wuduSteps)..shuffle(Random());
  }

  bool get _isCorrect {
    for (var i = 0; i < _slots.length; i++) {
      if (_slots[i].order != i + 1) return false;
    }
    return true;
  }

  Future<void> _check() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _checked = true;
      _feedback = _isCorrect ? l10n.correct : l10n.almost;
    });
    if (_isCorrect) {
      await Future<void>.delayed(const Duration(milliseconds: 800));
      final result = await ref.read(progressRepositoryProvider).completeGame(
            gameId: 'wudu_sequence',
            starsEarned: 3,
            xpEarned: 40,
            badgeId: 'wudu_explorer',
          );
      if (!mounted) return;
      context.go(
        '/victory',
        extra: VictoryArgs(
          titleGame: 'wudu',
          starsEarned: result.starsEarned,
          xpEarned: result.xpEarned,
          replayRoute: '/game/wudu',
          newBadges: result.newBadges,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = ref.watch(localeProvider).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.wuduTitle),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.go('/map'),
        ),
      ),
      body: GeometricBackground(
        topColor: AppColors.softTurquoise,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      l10n.wuduHint,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.wuduExplanation,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.darkText.withValues(alpha: 0.7),
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ReorderableListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _slots.length,
                  onReorderItem: (oldIndex, newIndex) {
                    setState(() {
                      final item = _slots.removeAt(oldIndex);
                      _slots.insert(newIndex, item);
                      _checked = false;
                      _feedback = null;
                    });
                  },
                  itemBuilder: (context, index) {
                    final step = _slots[index];
                    final ok = _checked && step.order == index + 1;
                    final bad = _checked && step.order != index + 1;
                    return Card(
                      key: ValueKey(step.id),
                      color: ok
                          ? AppColors.success.withValues(alpha: 0.25)
                          : bad
                              ? AppColors.softError.withValues(alpha: 0.2)
                              : Colors.white.withValues(alpha: 0.92),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryViolet.withValues(alpha: 0.2),
                          child: Icon(
                            _icons[step.iconId] ?? Icons.water_drop_rounded,
                            color: AppColors.royalPurple,
                          ),
                        ),
                        title: Text(
                          step.titleFor(locale),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(step.noteEn),
                        trailing: const Icon(Icons.drag_handle_rounded),
                      ),
                    );
                  },
                ),
              ),
              if (_feedback != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    _feedback!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: _isCorrect ? AppColors.success : AppColors.coral,
                        ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: BigKidButton(
                  label: l10n.wuduCheck,
                  icon: Icons.check_circle_rounded,
                  onPressed: _check,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
