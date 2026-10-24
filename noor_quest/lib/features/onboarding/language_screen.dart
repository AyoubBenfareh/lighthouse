import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/star_burst.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final current = ref.watch(localeProvider).languageCode;

    return Scaffold(
      body: GeometricBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Text(
                  l10n.chooseLanguage,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.royalPurple,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _LangCard(
                  label: l10n.languageArabic,
                  selected: current == 'ar',
                  flagColor: AppColors.softTurquoise,
                  onTap: () => ref.read(progressRepositoryProvider).setLocale('ar'),
                ),
                const SizedBox(height: 14),
                _LangCard(
                  label: l10n.languageGerman,
                  selected: current == 'de',
                  flagColor: AppColors.warmGold,
                  onTap: () => ref.read(progressRepositoryProvider).setLocale('de'),
                ),
                const SizedBox(height: 14),
                _LangCard(
                  label: l10n.languageEnglish,
                  selected: current == 'en',
                  flagColor: AppColors.primaryViolet,
                  onTap: () => ref.read(progressRepositoryProvider).setLocale('en'),
                ),
                const Spacer(),
                BigKidButton(
                  label: l10n.continueLabel,
                  icon: Icons.arrow_forward_rounded,
                  onPressed: () => context.go('/profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LangCard extends StatelessWidget {
  const _LangCard({
    required this.label,
    required this.selected,
    required this.flagColor,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color flagColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? flagColor.withValues(alpha: 0.35) : Colors.white.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          constraints: const BoxConstraints(minHeight: 72),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: selected ? AppColors.royalPurple : Colors.transparent,
              width: 3,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: flagColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              if (selected)
                const Icon(Icons.check_circle, color: AppColors.royalPurple, size: 32),
            ],
          ),
        ),
      ),
    );
  }
}
