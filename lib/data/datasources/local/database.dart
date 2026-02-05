import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Games, Statistics, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _initializeDefaultSettings();
      },
      onUpgrade: (Migrator m, int from, int to) async {},
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _initializeDefaultSettings() async {
    final existingSettings = await (select(
      settings,
    )..limit(1)).getSingleOrNull();
    if (existingSettings == null) {
      await into(
        settings,
      ).insert(SettingsCompanion.insert(updatedAt: DateTime.now()));
    }
  }

  Future<List<GameRecord>> getAllGames() {
    return (select(
      games,
    )..orderBy([(g) => OrderingTerm.desc(g.createdAt)])).get();
  }

  Future<List<GameRecord>> getGamesByBoardSize(String boardSize) {
    return (select(games)
          ..where((g) => g.boardSize.equals(boardSize))
          ..orderBy([(g) => OrderingTerm.desc(g.createdAt)]))
        .get();
  }

  Future<List<GameRecord>> getGamesByGameMode(String gameMode) {
    return (select(games)
          ..where((g) => g.gameMode.equals(gameMode))
          ..orderBy([(g) => OrderingTerm.desc(g.createdAt)]))
        .get();
  }

  Future<List<GameRecord>> getRecentGames({int limit = 10}) {
    return (select(games)
          ..orderBy([(g) => OrderingTerm.desc(g.createdAt)])
          ..limit(limit))
        .get();
  }

  Future<GameRecord?> getGameById(String id) {
    return (select(games)..where((g) => g.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertGame(GamesCompanion game) {
    return into(games).insert(game);
  }

  Future<bool> updateGame(GameRecord game) {
    return update(games).replace(game);
  }

  Future<int> deleteGame(String id) {
    return (delete(games)..where((g) => g.id.equals(id))).go();
  }

  Future<int> deleteAllGames() {
    return delete(games).go();
  }

  Future<int> countGames() async {
    final countExp = games.id.count();
    final query = selectOnly(games)..addColumns([countExp]);
    final result = await query.getSingle();
    return result.read(countExp) ?? 0;
  }

  Future<StatisticsRecord?> getStatistics(String boardSize, String gameMode) {
    return (select(statistics)..where(
          (s) => s.boardSize.equals(boardSize) & s.gameMode.equals(gameMode),
        ))
        .getSingleOrNull();
  }

  Future<List<StatisticsRecord>> getAllStatistics() {
    return select(statistics).get();
  }

  Future<void> upsertStatistics(StatisticsCompanion stats) async {
    await into(statistics).insertOnConflictUpdate(stats);
  }

  Future<void> updateStatisticsAfterGame({
    required String boardSize,
    required String gameMode,
    required String winner,
    required int movesCount,
    required int durationSeconds,
  }) async {
    final existing = await getStatistics(boardSize, gameMode);

    if (existing == null) {
      await into(statistics).insert(
        StatisticsCompanion.insert(
          boardSize: boardSize,
          gameMode: gameMode,
          totalGames: Value(1),
          xWins: Value(winner == 'x' ? 1 : 0),
          oWins: Value(winner == 'o' ? 1 : 0),
          draws: Value(winner == 'draw' ? 1 : 0),
          totalMoves: Value(movesCount),
          totalDurationSeconds: Value(durationSeconds),
          xWinStreak: Value(winner == 'x' ? 1 : 0),
          oWinStreak: Value(winner == 'o' ? 1 : 0),
          xBestStreak: Value(winner == 'x' ? 1 : 0),
          oBestStreak: Value(winner == 'o' ? 1 : 0),
          updatedAt: DateTime.now(),
        ),
      );
    } else {
      final newXStreak = winner == 'x' ? existing.xWinStreak + 1 : 0;
      final newOStreak = winner == 'o' ? existing.oWinStreak + 1 : 0;

      await (update(statistics)..where((s) => s.id.equals(existing.id))).write(
        StatisticsCompanion(
          totalGames: Value(existing.totalGames + 1),
          xWins: Value(existing.xWins + (winner == 'x' ? 1 : 0)),
          oWins: Value(existing.oWins + (winner == 'o' ? 1 : 0)),
          draws: Value(existing.draws + (winner == 'draw' ? 1 : 0)),
          totalMoves: Value(existing.totalMoves + movesCount),
          totalDurationSeconds: Value(
            existing.totalDurationSeconds + durationSeconds,
          ),
          xWinStreak: Value(newXStreak),
          oWinStreak: Value(newOStreak),
          xBestStreak: Value(
            newXStreak > existing.xBestStreak
                ? newXStreak
                : existing.xBestStreak,
          ),
          oBestStreak: Value(
            newOStreak > existing.oBestStreak
                ? newOStreak
                : existing.oBestStreak,
          ),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  Future<int> resetStatistics() {
    return delete(statistics).go();
  }

  Future<SettingsRecord> getSettings() async {
    final result = await (select(settings)..limit(1)).getSingleOrNull();
    if (result == null) {
      await _initializeDefaultSettings();
      return (select(settings)..limit(1)).getSingle();
    }
    return result;
  }

  Stream<SettingsRecord> watchSettings() {
    return (select(settings)..limit(1)).watchSingle();
  }

  Future<bool> updateSettings(SettingsCompanion newSettings) async {
    final rowsAffected = await (update(settings)..where((s) => s.id.equals(1)))
        .write(newSettings.copyWith(updatedAt: Value(DateTime.now())));
    return rowsAffected > 0;
  }

  Future<void> resetSettings() async {
    await (delete(settings)).go();
    await _initializeDefaultSettings();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tictactoe.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
