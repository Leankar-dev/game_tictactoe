import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/data/models/settings_model.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';

void main() {
  group('SettingsModel', () {
    group('defaults factory', () {
      test('should create model with default values', () {
        final settings = SettingsModel.defaults();

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

    group('copyWith', () {
      test('should create copy with updated fields', () {
        final original = SettingsModel.defaults();

        final updated = original.copyWith(
          soundEnabled: false,
          aiDifficulty: AiDifficulty.hard,
        );

        expect(updated.soundEnabled, false);
        expect(updated.aiDifficulty, AiDifficulty.hard);
        expect(updated.hapticEnabled, original.hapticEnabled);
        expect(updated.defaultBoardSize, original.defaultBoardSize);
      });

      test('should preserve unmodified fields', () {
        final original = SettingsModel.defaults().copyWith(
          playerXName: 'Alice',
          playerOName: 'Bob',
        );

        final updated = original.copyWith(themeMode: AppThemeMode.dark);

        expect(updated.playerXName, 'Alice');
        expect(updated.playerOName, 'Bob');
        expect(updated.themeMode, AppThemeMode.dark);
      });
    });

    group('toCompanion', () {
      test('should create valid companion for database', () {
        final settings = SettingsModel.defaults();
        final companion = settings.toCompanion();

        expect(companion.soundEnabled.value, true);
        expect(companion.hapticEnabled.value, true);
        expect(companion.aiDifficulty.value, 'medium');
        expect(companion.defaultBoardSize.value, 'classic');
        expect(companion.defaultGameMode.value, 'pvp');
      });
    });

    group('equality', () {
      test('should be equal for same values', () {
        final settings1 = SettingsModel.defaults();
        final settings2 = SettingsModel.defaults();

        expect(settings1.soundEnabled, settings2.soundEnabled);
        expect(settings1.hapticEnabled, settings2.hapticEnabled);
        expect(settings1.aiDifficulty, settings2.aiDifficulty);
      });
    });
  });

  group('AiDifficulty', () {
    group('displayName', () {
      test('should return correct display names', () {
        expect(AiDifficulty.easy.displayName, 'Easy');
        expect(AiDifficulty.medium.displayName, 'Medium');
        expect(AiDifficulty.hard.displayName, 'Hard');
      });
    });

    group('fromString', () {
      test('should parse valid strings', () {
        expect(AiDifficulty.fromString('easy'), AiDifficulty.easy);
        expect(AiDifficulty.fromString('medium'), AiDifficulty.medium);
        expect(AiDifficulty.fromString('hard'), AiDifficulty.hard);
      });

      test('should handle case insensitive', () {
        expect(AiDifficulty.fromString('EASY'), AiDifficulty.easy);
        expect(AiDifficulty.fromString('Medium'), AiDifficulty.medium);
        expect(AiDifficulty.fromString('HARD'), AiDifficulty.hard);
      });

      test('should return medium for invalid string', () {
        expect(AiDifficulty.fromString('invalid'), AiDifficulty.medium);
        expect(AiDifficulty.fromString(''), AiDifficulty.medium);
      });
    });
  });

  group('AppThemeMode', () {
    group('fromString', () {
      test('should parse valid strings', () {
        expect(AppThemeMode.fromString('light'), AppThemeMode.light);
        expect(AppThemeMode.fromString('dark'), AppThemeMode.dark);
        expect(AppThemeMode.fromString('system'), AppThemeMode.system);
      });

      test('should handle case insensitive', () {
        expect(AppThemeMode.fromString('LIGHT'), AppThemeMode.light);
        expect(AppThemeMode.fromString('Dark'), AppThemeMode.dark);
        expect(AppThemeMode.fromString('SYSTEM'), AppThemeMode.system);
      });

      test('should return light for invalid string', () {
        expect(AppThemeMode.fromString('invalid'), AppThemeMode.light);
        expect(AppThemeMode.fromString(''), AppThemeMode.light);
      });
    });
  });
}
