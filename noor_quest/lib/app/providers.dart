import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final bootstrapProvider = FutureProvider<void>((ref) async {
  final db = ref.watch(databaseProvider);
  await db.ensureSeeded();
  await ref.watch(speechServiceProvider).init();
});
