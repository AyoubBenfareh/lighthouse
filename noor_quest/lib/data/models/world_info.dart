enum WorldId {
  arabic,
  prayer,
  garden,
  manners,
  quran,
}

class WorldInfo {
  const WorldInfo({
    required this.id,
    required this.routeGame,
    required this.playable,
    required this.comingSoon,
    required this.mapX,
    required this.mapY,
    required this.accent,
  });

  final WorldId id;
  final String? routeGame;
  final bool playable;
  final bool comingSoon;
  final double mapX;
  final double mapY;
  final int accent;

  static const all = <WorldInfo>[
    WorldInfo(
      id: WorldId.arabic,
      routeGame: '/game/arabic',
      playable: true,
      comingSoon: false,
      mapX: 0.18,
      mapY: 0.32,
      accent: 0xFF7EC8E8,
    ),
    WorldInfo(
      id: WorldId.prayer,
      routeGame: '/game/wudu',
      playable: true,
      comingSoon: false,
      mapX: 0.55,
      mapY: 0.22,
      accent: 0xFF6DD9C5,
    ),
    WorldInfo(
      id: WorldId.garden,
      routeGame: null,
      playable: false,
      comingSoon: true,
      mapX: 0.78,
      mapY: 0.42,
      accent: 0xFF7BC47F,
    ),
    WorldInfo(
      id: WorldId.manners,
      routeGame: '/game/manners',
      playable: true,
      comingSoon: false,
      mapX: 0.32,
      mapY: 0.68,
      accent: 0xFFF5A9C5,
    ),
    WorldInfo(
      id: WorldId.quran,
      routeGame: null,
      playable: false,
      comingSoon: true,
      mapX: 0.72,
      mapY: 0.72,
      accent: 0xFFF2C66D,
    ),
  ];
}
