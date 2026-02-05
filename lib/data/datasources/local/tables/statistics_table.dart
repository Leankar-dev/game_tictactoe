import 'package:drift/drift.dart';

@DataClassName('StatisticsRecord')
class Statistics extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get boardSize => text().withLength(min: 1, max: 20)();

  TextColumn get gameMode => text().withLength(min: 1, max: 20)();

  IntColumn get totalGames => integer().withDefault(const Constant(0))();

  IntColumn get xWins => integer().withDefault(const Constant(0))();

  IntColumn get oWins => integer().withDefault(const Constant(0))();

  IntColumn get draws => integer().withDefault(const Constant(0))();

  IntColumn get totalMoves => integer().withDefault(const Constant(0))();

  IntColumn get totalDurationSeconds =>
      integer().withDefault(const Constant(0))();

  IntColumn get xWinStreak => integer().withDefault(const Constant(0))();

  IntColumn get oWinStreak => integer().withDefault(const Constant(0))();

  IntColumn get xBestStreak => integer().withDefault(const Constant(0))();

  IntColumn get oBestStreak => integer().withDefault(const Constant(0))();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column>>? get uniqueKeys => [
    {boardSize, gameMode},
  ];
}
