import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/painters/noor_lantern_painter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/star_burst.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameCtrl = TextEditingController();
  int _avatar = 0;

  static const _avatarColors = [
    AppColors.warmGold,
    AppColors.softTurquoise,
    AppColors.softPink,
    AppColors.skyBlue,
    AppColors.leafGreen,
    AppColors.primaryViolet,
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    await ref.read(progressRepositoryProvider).completeOnboarding(
          displayName: _nameCtrl.text.isEmpty ? 'Noor Friend' : _nameCtrl.text,
          avatarIndex: _avatar,
        );
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: GeometricBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.createProfile,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.royalPurple,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.pickAvatar,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(_avatarColors.length, (i) {
                    final selected = _avatar == i;
                    return GestureDetector(
                      onTap: () => setState(() => _avatar = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          color: _avatarColors[i].withValues(alpha: 0.35),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selected
                                ? AppColors.royalPurple
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: CustomPaint(
                            size: const Size.square(52),
                            painter: NoorLanternPainter(
                              glow: selected ? 1.1 : 0.7,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 28),
                Text(
                  l10n.adventurerName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(hintText: l10n.nameHint),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 8),
                Text(
                  // Privacy: no PII — optional nickname only.
                  'No personal info needed — nickname only.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.darkText.withValues(alpha: 0.7),
                      ),
                ),
                const SizedBox(height: 32),
                BigKidButton(
                  label: l10n.startAdventure,
                  icon: Icons.explore_rounded,
                  onPressed: _start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
