import 'package:drift/drift.dart';

@DataClassName('SettingsRecord')
class Settings extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();

  BoolColumn get soundEnabled => boolean().withDefault(const Constant(true))();

  BoolColumn get hapticEnabled => boolean().withDefault(const Constant(true))();

  TextColumn get aiDifficulty => text().withDefault(const Constant('medium'))();

  TextColumn get defaultBoardSize =>
      text().withDefault(const Constant('classic'))();

  TextColumn get defaultGameMode => text().withDefault(const Constant('pvp'))();

  TextColumn get themeMode => text().withDefault(const Constant('light'))();

  TextColumn get playerXName =>
      text().withDefault(const Constant('Player X'))();

  TextColumn get playerOName =>
      text().withDefault(const Constant('Player O'))();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
