import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/audio/sound_manager.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/star_burst.dart';

class ParentGateScreen extends ConsumerStatefulWidget {
  const ParentGateScreen({super.key});

  @override
  ConsumerState<ParentGateScreen> createState() => _ParentGateScreenState();
}

class _ParentGateScreenState extends ConsumerState<ParentGateScreen> {
  late final int _a;
  late final int _b;
  final _mathCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    final rng = Random();
    _a = 3 + rng.nextInt(7);
    _b = 2 + rng.nextInt(8);
  }

  @override
  void dispose() {
    _mathCtrl.dispose();
    _pinCtrl.dispose();
    super.dispose();
  }

  Future<void> _unlock() async {
    ref.read(parentUnlockedProvider.notifier).state = true;
    ref.read(soundManagerProvider).play(Sfx.unlock);
    if (mounted) context.go('/parent');
  }

  Future<void> _submitMath() async {
    final l10n = AppLocalizations.of(context);
    final answer = int.tryParse(_mathCtrl.text.trim());
    if (answer == _a + _b) {
      await _unlock();
    } else {
      ref.read(soundManagerProvider).play(Sfx.incorrect);
      setState(() => _error = l10n.parentGateWrong);
    }
  }

  Future<void> _submitPin() async {
    final l10n = AppLocalizations.of(context);
    final ok = await ref
        .read(progressRepositoryProvider)
        .verifyParentPin(_pinCtrl.text.trim());
    if (ok) {
      await _unlock();
    } else {
      ref.read(soundManagerProvider).play(Sfx.incorrect);
      setState(() => _error = l10n.parentGateWrong);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hasPin = ref.watch(profileProvider).value?.hasParentPin ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.parentGateTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: GeometricBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.parentGatePrompt(_a, _b),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.royalPurple,
                      ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _mathCtrl,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  decoration: const InputDecoration(hintText: '?'),
                  onSubmitted: (_) => _submitMath(),
                ),
                if (hasPin) ...[
                  const SizedBox(height: 20),
                  Text(l10n.parentGatePin, textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _pinCtrl,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: l10n.parentPinHint),
                    onSubmitted: (_) => _submitPin(),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: _submitPin,
                    child: Text(l10n.parentGatePin),
                  ),
                ],
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.softError),
                  ),
                ],
                const Spacer(),
                BigKidButton(label: l10n.continueLabel, onPressed: _submitMath),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
