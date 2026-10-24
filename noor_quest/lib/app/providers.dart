import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../core/audio/sound_manager.dart';
import '../core/audio/speech_service.dart';
import '../data/database/app_database.dart';
import '../data/repositories/progress_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  return ProgressRepository(ref.watch(databaseProvider));
});

final speechServiceProvider = Provider<SpeechService>((ref) {
  final service = SpeechService();
  ref.onDispose(service.stop);
  return service;
});

final soundManagerProvider = Provider<SoundManager>((ref) {
  final mgr = SoundManager();
  ref.onDispose(mgr.dispose);
  return mgr;
});

final progressProvider = StreamProvider<ProgressSnapshot>((ref) {
  return ref.watch(progressRepositoryProvider).watchProgress();
});

final profileProvider = StreamProvider<ProfileSnapshot>((ref) {
  return ref.watch(progressRepositoryProvider).watchProfile();
});

final localeProvider = Provider<Locale>((ref) {
  final profile = ref.watch(profileProvider).value;
  final code = profile?.localeCode ?? 'en';
  return Locale(code);
});

/// Parent area session unlock (in-memory). Cleared when app restarts.
final parentUnlockedProvider = StateProvider<bool>((ref) => false);

final bootstrapProvider = FutureProvider<void>((ref) async {
  final db = ref.watch(databaseProvider);
  await db.ensureSeeded();
  final speech = ref.watch(speechServiceProvider);
  final sound = ref.watch(soundManagerProvider);
  await Future.wait([speech.init(), sound.init()]);
  final profile = await ref.read(progressRepositoryProvider).getProfile();
  sound.enabled = profile.audioEnabled;
  sound.volume = profile.sfxVolume;
});
