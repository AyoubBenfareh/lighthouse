import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../core/painters/geometric_bg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/star_burst.dart';

class ParentGateScreen extends StatefulWidget {
  const ParentGateScreen({super.key});

  @override
  State<ParentGateScreen> createState() => _ParentGateScreenState();
}

class _ParentGateScreenState extends State<ParentGateScreen> {
  late final int _a;
  late final int _b;
  final _ctrl = TextEditingController();
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
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() {
    final l10n = AppLocalizations.of(context);
    final answer = int.tryParse(_ctrl.text.trim());
    if (answer == _a + _b) {
      context.go('/parent');
    } else {
      setState(() => _error = l10n.parentGateWrong);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.parentGateTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: GeometricBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Text(
                  l10n.parentGatePrompt(_a, _b),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.royalPurple,
                      ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _ctrl,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  decoration: const InputDecoration(
                    hintText: '?',
                  ),
                  onSubmitted: (_) => _submit(),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.softError),
                  ),
                ],
                const Spacer(),
                BigKidButton(
                  label: l10n.continueLabel,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
