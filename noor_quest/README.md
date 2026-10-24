# Noor Quest — مغامرات نور (V2)

Tagline: **Play, Explore, and Learn** / العب، اكتشف، وتعلّم

Offline Islamic educational adventure for Muslim children (ages 6–10).

Built with **Flutter + Flame + Riverpod + GoRouter + Drift/SQLite** and ARB localization (**ar**, **de**, **en**).

This app lives in `noor_quest/` so it does not overwrite the existing Lighthouse AAC project at the repository root.

## Features (V2)

- Professional logo + launcher icons
- Illustrated adventure map with distinct islands
- 6 distinct avatars + richer Noor mascot
- Non-musical SFX + Arabic letter/vocab pronunciation
- Reward idempotency + parent PIN / route protection
- Arabic pathway stages, Garden pillars intro, offline Noor Teacher
- Premium/ads/AI scaffolding (disabled — no paid services)

## Features (MVP retained)

- Splash, language selection, child avatar profile (no PII)
- Adventure home with **Noor** lantern companion (CustomPainter)
- Interactive world map (5 islands; Quran Oasis & Garden marked coming soon)
- **3 playable mini-games**
  1. Arabic Letter Adventure
  2. Wudu Sequence Challenge (drag-and-drop)
  3. Good Manners scenarios (5 situations)
- Victory screen, achievements/badges, parent-gated settings
- Offline progress (stars, XP, unlocks, badges) via Drift/SQLite
- Optional on-device TTS for ordinary vocabulary (graceful degrade)

Stars are **educational rewards only** — never spiritual merit.

## Requirements

- Flutter **3.47+** (Dart 3.13+)
- For Android APK: Android SDK 36 + Build-Tools

```bash
flutter doctor
```

## Run

```bash
cd noor_quest
flutter pub get
dart run build_runner build   # regenerates Drift if schema changes
flutter gen-l10n              # usually automatic via l10n.yaml
flutter run
```

Useful targets:

```bash
flutter run -d chrome     # web
flutter run -d linux      # desktop (needs GTK)
flutter run -d android
```

## Test

```bash
cd noor_quest
flutter test
flutter analyze
```

## Build debug APK

```bash
cd noor_quest
flutter build apk --debug
# Output: build/app/outputs/flutter-apk/app-debug.apk
```

Release APK (local signing only; do not publish without owner approval):

```bash
flutter build apk --release
```

## Project layout

```text
lib/
  main.dart
  app/           # MaterialApp, GoRouter, Riverpod providers
  core/          # theme, painters, widgets, audio
  features/      # splash, onboarding, home, map, games, parent, …
  game/          # Flame components
  data/          # Drift DB, repositories, lesson catalog
  l10n/          # ARB + generated localizations
docs/
  CONTENT_REVIEW_CHECKLIST.md
```

## Content review

Educational copy is **pending Islamic educator review**.  
See [`docs/CONTENT_REVIEW_CHECKLIST.md`](docs/CONTENT_REVIEW_CHECKLIST.md).

## Constraints (MVP)

- Offline-only; no Firebase/ads/accounts/AI APIs
- No Quran TTS; no depictions of Allah/prophets/angels
- Parent area behind a simple math gate

## License fonts

- Nunito and Noto Naskh Arabic — SIL Open Font License (bundled under `assets/fonts/`)
