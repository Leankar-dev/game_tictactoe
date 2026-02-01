import 'package:drift/drift.dart';

@DataClassName('GameRecord')
class Games extends Table {
  TextColumn get id => text()();

  TextColumn get boardSize => text().withLength(min: 1, max: 20)();

  TextColumn get gameMode => text().withLength(min: 1, max: 20)();

  TextColumn get winner => text().withLength(min: 1, max: 10)();

  IntColumn get movesCount => integer()();

  IntColumn get durationSeconds => integer().withDefault(const Constant(0))();

  TextColumn get moveHistory => text().withDefault(const Constant('[]'))();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
