import '../datasources/local/database.dart';
import '../models/models.dart';
import '../../domain/enums/enums.dart';

class SettingsRepository {
  final AppDatabase _database;

  const SettingsRepository(this._database);

  Future<SettingsModel> getSettings() async {
    final record = await _database.getSettings();
    return SettingsModel.fromRecord(record);
  }

  Stream<SettingsModel> watchSettings() {
    return _database.watchSettings().map(SettingsModel.fromRecord);
  }

  Future<void> updateSettings(SettingsModel settings) async {
    await _database.updateSettings(settings.toCompanion());
  }

  Future<void> updateSoundEnabled(bool enabled) async {
    final current = await getSettings();
    await updateSettings(current.copyWith(soundEnabled: enabled));
  }

  Future<void> updateHapticEnabled(bool enabled) async {
    final current = await getSettings();
    await updateSettings(current.copyWith(hapticEnabled: enabled));
  }

  Future<void> updateAiDifficulty(AiDifficulty difficulty) async {
    final current = await getSettings();
    await updateSettings(current.copyWith(aiDifficulty: difficulty));
  }

  Future<void> updateDefaultBoardSize(BoardSize boardSize) async {
    final current = await getSettings();
    await updateSettings(current.copyWith(defaultBoardSize: boardSize));
  }

  Future<void> updateDefaultGameMode(GameMode gameMode) async {
    final current = await getSettings();
    await updateSettings(current.copyWith(defaultGameMode: gameMode));
  }

  Future<void> updateThemeMode(AppThemeMode themeMode) async {
    final current = await getSettings();
    await updateSettings(current.copyWith(themeMode: themeMode));
  }

  Future<void> updatePlayerNames({String? playerX, String? playerO}) async {
    final current = await getSettings();
    await updateSettings(current.copyWith(
      playerXName: playerX,
      playerOName: playerO,
    ));
  }

  Future<void> resetSettings() async {
    await _database.resetSettings();
  }
}
