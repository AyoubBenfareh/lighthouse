import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/achievements/achievements_screen.dart';
import '../features/adventure_map/adventure_map_screen.dart';
import '../features/arabic_letters/arabic_letters_screen.dart';
import '../features/home/home_screen.dart';
import '../features/manners_game/manners_game_screen.dart';
import '../features/onboarding/language_screen.dart';
import '../features/onboarding/profile_screen.dart';
import '../features/parent_area/parent_area_screen.dart';
import '../features/parent_area/parent_gate_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/victory/victory_screen.dart';
import '../features/wudu_game/wudu_game_screen.dart';
import 'providers.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/language',
        builder: (context, state) => const LanguageScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/map',
        builder: (context, state) => const AdventureMapScreen(),
      ),
      GoRoute(
        path: '/game/arabic',
        builder: (context, state) => const ArabicLettersScreen(),
      ),
      GoRoute(
        path: '/game/wudu',
        builder: (context, state) => const WuduGameScreen(),
      ),
      GoRoute(
        path: '/game/manners',
        builder: (context, state) => const MannersGameScreen(),
      ),
      GoRoute(
        path: '/victory',
        builder: (context, state) {
          final extra = state.extra as VictoryArgs?;
          return VictoryScreen(args: extra ?? VictoryArgs.demo());
        },
      ),
      GoRoute(
        path: '/achievements',
        builder: (context, state) => const AchievementsScreen(),
      ),
      GoRoute(
        path: '/parent-gate',
        builder: (context, state) => const ParentGateScreen(),
      ),
      GoRoute(
        path: '/parent',
        builder: (context, state) => const ParentAreaScreen(),
      ),
    ],
    redirect: (context, state) {
      final boot = ref.read(bootstrapProvider);
      if (boot.isLoading || boot.hasError) return null;
      final profile = ref.read(profileProvider).value;
      if (profile == null) return null;
      final loc = state.matchedLocation;
      if (loc == '/splash') return null;
      if (!profile.onboardingComplete) {
        if (loc == '/language' || loc == '/profile') return null;
        return '/language';
      }
      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Route error: ${state.error}')),
    ),
  );
});
