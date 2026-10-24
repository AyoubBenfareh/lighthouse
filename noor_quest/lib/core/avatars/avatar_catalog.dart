import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum AvatarKind {
  explorer,
  desertFox,
  bird,
  cat,
  starKid,
  gardenExplorer,
}

class AvatarDef {
  const AvatarDef({
    required this.kind,
    required this.nameKey,
    required this.primary,
    required this.accent,
  });

  final AvatarKind kind;
  final String nameKey; // l10n key handled in UI
  final Color primary;
  final Color accent;

  static const all = <AvatarDef>[
    AvatarDef(
      kind: AvatarKind.explorer,
      nameKey: 'avatarExplorer',
      primary: AppColors.primaryViolet,
      accent: AppColors.warmGold,
    ),
    AvatarDef(
      kind: AvatarKind.desertFox,
      nameKey: 'avatarDesertFox',
      primary: Color(0xFFE07A3A),
      accent: Color(0xFFFFD7A8),
    ),
    AvatarDef(
      kind: AvatarKind.bird,
      nameKey: 'avatarBird',
      primary: AppColors.skyBlue,
      accent: AppColors.softTurquoise,
    ),
    AvatarDef(
      kind: AvatarKind.cat,
      nameKey: 'avatarCat',
      primary: Color(0xFF8B7355),
      accent: AppColors.softPink,
    ),
    AvatarDef(
      kind: AvatarKind.starKid,
      nameKey: 'avatarStarKid',
      primary: AppColors.warmGold,
      accent: AppColors.royalPurple,
    ),
    AvatarDef(
      kind: AvatarKind.gardenExplorer,
      nameKey: 'avatarGardenExplorer',
      primary: AppColors.leafGreen,
      accent: Color(0xFFB8F2C0),
    ),
  ];
}
