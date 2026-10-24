import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../core/ai/ai_config.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/painters/noor_lantern_painter.dart';
import '../../core/theme/app_colors.dart';

/// Offline curated tutor mode — no cloud AI.
class NoorTeacherScreen extends ConsumerWidget {
  const NoorTeacherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tips = [
      (l10n.arabicLettersTitle, l10n.arabicLettersHint),
      (l10n.wuduTitle, l10n.wuduHint),
      (l10n.mannersTitle, l10n.mannersHint),
      (l10n.gardenTitle, l10n.gardenHint),
      (l10n.starsAreRewards, l10n.teacherOfflineOnly),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.teacherTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: GeometricBackground(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Center(child: AnimatedNoorLantern(size: 120)),
            const SizedBox(height: 12),
            Text(
              l10n.teacherHint,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.royalPurple,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.teacherOfflineOnly,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (!AiConfig.cloudEnabled) ...[
              const SizedBox(height: 8),
              Text(
                l10n.aiDisabled,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.darkText.withValues(alpha: 0.7),
                    ),
              ),
            ],
            const SizedBox(height: 16),
            ...tips.map(
              (t) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.$1,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(t.$2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
