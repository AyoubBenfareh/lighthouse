import 'package:flutter_test/flutter_test.dart';
import 'package:lighthouse/models/models.dart';
import 'package:lighthouse/services/backup/aac_backup_service.dart';
import 'package:lighthouse/services/obf/open_board_format.dart';
import 'package:lighthouse/services/profile/profile_store.dart';
import 'package:lighthouse/services/settings/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('OpenBoardFormat tests', () {
    test('isOBF identifies valid open-board documents', () {
      final obf = {
        'format': 'open-board-0.1',
        'id': 'test_obf',
        'name': 'Test OBF Board',
        'grid': {'rows': 2, 'columns': 2, 'order': []},
        'buttons': [],
      };

      expect(OpenBoardFormat.isOBF(obf), isTrue);
      expect(OpenBoardFormat.isOBF({'schema_version': '1.3'}), isFalse);
    });

    test('toAACBoard imports OBF format into functional AACBoard', () {
      final obfDoc = {
        'format': 'open-board-0.1',
        'id': 'colors_obf',
        'name': 'Colors Board',
        'grid': {
          'rows': 2,
          'columns': 2,
          'order': [
            ['btn_red', 'btn_blue'],
            ['btn_green', null],
          ],
        },
        'buttons': [
          {
            'id': 'btn_red',
            'label': 'Red',
            'vocalization': 'I want red',
            'image_url': 'assets/symbols/red.svg',
          },
          {
            'id': 'btn_blue',
            'label': 'Blue',
            'vocalization': 'Blue',
          },
          {
            'id': 'btn_green',
            'label': 'Green',
            'vocalization': 'Green',
          },
        ],
      };

      final board = OpenBoardFormat.toAACBoard(obfDoc);
      expect(board.boardId, equals('colors_obf'));
      expect(board.boardName, equals('Colors Board'));
      expect(board.gridDimensions.rows, equals(2));
      expect(board.gridDimensions.cols, equals(2));
      expect(board.buttons.length, equals(3));

      final red = board.buttons.firstWhere((b) => b.label == 'Red');
      expect(red.position, equals((row: 0, col: 0)));
      expect(red.voiceOut, equals('I want red'));
      expect(red.iconUri, equals('assets/symbols/red.svg'));

      final blue = board.buttons.firstWhere((b) => b.label == 'Blue');
      expect(blue.position, equals((row: 0, col: 1)));
    });

    test('toOBF converts AACBoard into standard open-board-0.1 JSON', () {
      final board = AACBoard(
        schemaVersion: '1.3',
        boardId: 'animals',
        boardName: 'Animals',
        gridDimensions: (rows: 1, cols: 2),
        colorKey: {'general': '#E0E0E0'},
        buttons: [
          const AACButton(
            id: 'btn_cat',
            label: 'Cat',
            labelByLocale: {},
            type: AACButtonType.word,
            position: (row: 0, col: 0),
            category: 'general',
            baseWeight: 1.0,
            iconUri: 'assets/cat.svg',
            voiceOut: 'Cat',
          ),
          const AACButton(
            id: 'btn_dog',
            label: 'Dog',
            labelByLocale: {},
            type: AACButtonType.word,
            position: (row: 0, col: 1),
            category: 'general',
            baseWeight: 1.0,
            iconUri: 'assets/dog.svg',
            voiceOut: 'Dog',
          ),
        ],
      );

      final obf = OpenBoardFormat.toOBF(board);
      expect(obf['format'], equals('open-board-0.1'));
      expect(obf['id'], equals('animals'));
      expect(obf['name'], equals('Animals'));
      expect(obf['grid']['rows'], equals(1));
      expect(obf['grid']['columns'], equals(2));
      final buttons = obf['buttons'] as List;
      expect(buttons.length, equals(2));
      expect(buttons.first['label'], equals('Cat'));
    });
  });

  group('AACBackupService tests', () {
    test('createBackupBundle captures profiles, active profile, and settings', () async {
      final profileStore = ProfileStore();
      final settingsRepo = SettingsRepository();

      await profileStore.createProfile(
        name: 'Sara',
        interfaceLocale: 'ar_dz',
        speechLocale: 'ar_dz',
        voiceRate: 0.85,
      );

      await settingsRepo.setLocaleOverride('ar_dz');
      await settingsRepo.setSpeechLocaleOverride('ar_dz');
      await settingsRepo.setAccessMethod(AccessMethod.switchSingle);
      await settingsRepo.setSwitchDwellMs(750);
      await settingsRepo.setVoiceRate(0.85);

      final service = AACBackupService(
        profileStore: profileStore,
        settingsRepo: settingsRepo,
      );

      final bundle = await service.createBackupBundle();
      expect(bundle['format'], equals(AACBackupService.currentBackupFormat));
      expect(bundle['profiles'], isA<List>());
      final profiles = bundle['profiles'] as List;
      expect(profiles.any((p) => p['name'] == 'Sara'), isTrue);

      final settings = bundle['settings'] as Map<String, dynamic>;
      expect(settings['locale_override'], equals('ar_dz'));
      expect(settings['access_method'], equals('switchSingle'));
      expect(settings['switch_dwell_ms'], equals(750));
      expect(settings['voice_rate'], equals(0.85));
    });

    test('restoreBackupBundle restores configuration into fresh stores', () async {
      final sourceProfileStore = ProfileStore();
      final sourceSettingsRepo = SettingsRepository();

      final p = await sourceProfileStore.createProfile(
        name: 'Yacine',
        interfaceLocale: 'ar',
        speechLocale: 'ar_dz',
      );
      await sourceProfileStore.setActiveProfileId(p.id);
      await sourceSettingsRepo.setAccessMethod(AccessMethod.switchDual);

      final service = AACBackupService(
        profileStore: sourceProfileStore,
        settingsRepo: sourceSettingsRepo,
      );

      final bundle = await service.createBackupBundle();

      // Clear SharedPreferences to simulate new device or fresh install
      SharedPreferences.setMockInitialValues({});

      final targetProfileStore = ProfileStore();
      final targetSettingsRepo = SettingsRepository();
      final targetService = AACBackupService(
        profileStore: targetProfileStore,
        settingsRepo: targetSettingsRepo,
      );

      final result = await targetService.restoreBackupBundle(bundle);
      expect(result.success, isTrue);
      expect(result.activeProfileId, equals(p.id));

      final restoredProfiles = await targetProfileStore.listProfiles();
      expect(restoredProfiles.any((p) => p.name == 'Yacine'), isTrue);

      final restoredActive = await targetProfileStore.getActiveProfile();
      expect(restoredActive.name, equals('Yacine'));

      final restoredSettings = await targetSettingsRepo.read();
      expect(restoredSettings.accessMethod, equals(AccessMethod.switchDual));
    });

    test('Rejects invalid backup format safely', () async {
      final service = AACBackupService(
        profileStore: ProfileStore(),
        settingsRepo: SettingsRepository(),
      );

      final result = await service.restoreBackupBundle({
        'format': 'unknown-format-9.9',
      });

      expect(result.success, isFalse);
      expect(result.errorMessage, contains('Unsupported backup format'));
    });
  });
}
