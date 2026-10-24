import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../core/theme/app_theme.dart';
import 'providers.dart';
import 'router.dart';

class NoorQuestApp extends ConsumerWidget {
  const NoorQuestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(bootstrapProvider);
    final locale = ref.watch(localeProvider);
    final router = ref.watch(routerProvider);
    final isArabic = locale.languageCode == 'ar';

    return MaterialApp.router(
      title: 'Noor Quest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(isArabic: isArabic),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
