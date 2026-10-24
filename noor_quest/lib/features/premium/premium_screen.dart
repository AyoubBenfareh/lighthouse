import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../core/ads/ads_config.dart';
import '../../core/ai/ai_config.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/theme/app_colors.dart';
import '../../features/premium/iap_scaffold.dart';

class PremiumScreen extends ConsumerWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.premiumTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/parent'),
        ),
      ),
      body: GeometricBackground(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              l10n.premiumBody,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(l10n.premiumBlocked),
            const SizedBox(height: 8),
            Text(l10n.accountScaffold),
            const SizedBox(height: 8),
            Text(AdsConfig.enabled ? 'Ads on' : l10n.adsDisabled),
            Text(AiConfig.cloudEnabled ? 'AI on' : l10n.aiDisabled),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final msg = await IapScaffold.purchaseFamilyPlus();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.royalPurple),
              child: Text(l10n.premiumTitle),
            ),
          ],
        ),
      ),
    );
  }
}
