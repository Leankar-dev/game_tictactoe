import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/data/models/settings_model.dart';
import 'package:game_tictactoe/data/repositories/settings_repository.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';

import 'test_database.dart';

void main() {
  late SettingsRepository repository;

  setUp(() async {
    final database = createTestDatabase();
    repository = SettingsRepository(database);
  });

  group('SettingsRepository', () {
    group('getSettings', () {
      test('should return default settings initially', () async {
        final settings = await repository.getSettings();

        expect(settings.soundEnabled, true);
        expect(settings.hapticEnabled, true);
        expect(settings.aiDifficulty, AiDifficulty.medium);
        expect(settings.defaultBoardSize, BoardSize.classic);
        expect(settings.defaultGameMode, GameMode.playerVsPlayer);
        expect(settings.themeMode, AppThemeMode.light);
        expect(settings.playerXName, 'Player X');
        expect(settings.playerOName, 'Player O');
      });
    });

    group('updateSettings', () {
      test('should update all settings', () async {
        final newSettings = SettingsModel(
          soundEnabled: false,
          hapticEnabled: false,
          aiDifficulty: AiDifficulty.hard,
          defaultBoardSize: BoardSize.extended,
          defaultGameMode: GameMode.playerVsCpu,
          themeMode: AppThemeMode.dark,
          playerXName: 'Alice',
          playerOName: 'Bob',
          updatedAt: DateTime.now(),
        );

        await repository.updateSettings(newSettings);
        final saved = await repository.getSettings();

        expect(saved.soundEnabled, false);
        expect(saved.hapticEnabled, false);
        expect(saved.aiDifficulty, AiDifficulty.hard);
        expect(saved.defaultBoardSize, BoardSize.extended);
        expect(saved.defaultGameMode, GameMode.playerVsCpu);
        expect(saved.themeMode, AppThemeMode.dark);
        expect(saved.playerXName, 'Alice');
        expect(saved.playerOName, 'Bob');
      });
    });

    group('individual updates', () {
      test('updateSoundEnabled should only change sound', () async {
        await repository.updateSoundEnabled(false);
        final settings = await repository.getSettings();

        expect(settings.soundEnabled, false);
        expect(settings.hapticEnabled, true);
      });

      test('updateHapticEnabled should only change haptic', () async {
        await repository.updateHapticEnabled(false);
        final settings = await repository.getSettings();

        expect(settings.hapticEnabled, false);
        expect(settings.soundEnabled, true);
      });

      test('updateAiDifficulty should change difficulty', () async {
        await repository.updateAiDifficulty(AiDifficulty.hard);
        final settings = await repository.getSettings();

        expect(settings.aiDifficulty, AiDifficulty.hard);
      });

      test('updatePlayerNames should change both names', () async {
        await repository.updatePlayerNames(
          playerX: 'Player One',
          playerO: 'CPU',
        );
        final settings = await repository.getSettings();

        expect(settings.playerXName, 'Player One');
        expect(settings.playerOName, 'CPU');
      });
    });

    group('resetSettings', () {
      test('should restore default settings', () async {
        await repository.updateSoundEnabled(false);
        await repository.updateAiDifficulty(AiDifficulty.hard);
        await repository.updatePlayerNames(playerX: 'Test', playerO: 'Test2');

        await repository.resetSettings();
        final settings = await repository.getSettings();

        expect(settings.soundEnabled, true);
        expect(settings.aiDifficulty, AiDifficulty.medium);
        expect(settings.playerXName, 'Player X');
        expect(settings.playerOName, 'Player O');
      });
    });

    group('watchSettings', () {
      test('should emit settings changes', () async {
        final emissions = <SettingsModel>[];
        final subscription = repository.watchSettings().listen(emissions.add);

        await Future.delayed(const Duration(milliseconds: 50));
        await repository.updateSoundEnabled(false);
        await Future.delayed(const Duration(milliseconds: 50));

        await subscription.cancel();

        expect(emissions.length, greaterThanOrEqualTo(1));
        expect(emissions.last.soundEnabled, false);
      });
    });
  });
}
