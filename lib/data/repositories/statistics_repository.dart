import '../datasources/local/database.dart';
import '../models/models.dart';
import '../../domain/enums/enums.dart';

class StatisticsRepository {
  final AppDatabase _database;

  const StatisticsRepository(this._database);

  Future<StatisticsModel> getStatistics({
    required BoardSize boardSize,
    required GameMode gameMode,
  }) async {
    final sizeString = boardSize == BoardSize.classic ? 'classic' : 'extended';
    final modeString = gameMode == GameMode.playerVsPlayer ? 'pvp' : 'pvc';

    final record = await _database.getStatistics(sizeString, modeString);

    if (record == null) {
      return StatisticsModel.empty(boardSize: boardSize, gameMode: gameMode);
    }

    return StatisticsModel.fromRecord(record);
  }

  Future<List<StatisticsModel>> getAllStatistics() async {
    final records = await _database.getAllStatistics();
    return records.map(StatisticsModel.fromRecord).toList();
  }

  Future<StatisticsModel> getCombinedStatistics(BoardSize boardSize) async {
    final pvpStats = await getStatistics(
      boardSize: boardSize,
      gameMode: GameMode.playerVsPlayer,
    );
    final pvcStats = await getStatistics(
      boardSize: boardSize,
      gameMode: GameMode.playerVsCpu,
    );

    return StatisticsModel(
      boardSize: boardSize,
      gameMode: GameMode.playerVsPlayer,
      totalGames: pvpStats.totalGames + pvcStats.totalGames,
      xWins: pvpStats.xWins + pvcStats.xWins,
      oWins: pvpStats.oWins + pvcStats.oWins,
      draws: pvpStats.draws + pvcStats.draws,
      totalMoves: pvpStats.totalMoves + pvcStats.totalMoves,
      totalDurationSeconds:
          pvpStats.totalDurationSeconds + pvcStats.totalDurationSeconds,
      xWinStreak: pvpStats.xWinStreak > pvcStats.xWinStreak
          ? pvpStats.xWinStreak
          : pvcStats.xWinStreak,
      oWinStreak: pvpStats.oWinStreak > pvcStats.oWinStreak
          ? pvpStats.oWinStreak
          : pvcStats.oWinStreak,
      xBestStreak: pvpStats.xBestStreak > pvcStats.xBestStreak
          ? pvpStats.xBestStreak
          : pvcStats.xBestStreak,
      oBestStreak: pvpStats.oBestStreak > pvcStats.oBestStreak
          ? pvpStats.oBestStreak
          : pvcStats.oBestStreak,
      updatedAt: pvpStats.updatedAt.isAfter(pvcStats.updatedAt)
          ? pvpStats.updatedAt
          : pvcStats.updatedAt,
    );
  }

  Future<StatisticsModel> getTotalStatistics() async {
    final allStats = await getAllStatistics();

    if (allStats.isEmpty) {
      return StatisticsModel.empty(
        boardSize: BoardSize.classic,
        gameMode: GameMode.playerVsPlayer,
      );
    }

    return allStats.reduce(
      (a, b) => StatisticsModel(
        boardSize: BoardSize.classic,
        gameMode: GameMode.playerVsPlayer,
        totalGames: a.totalGames + b.totalGames,
        xWins: a.xWins + b.xWins,
        oWins: a.oWins + b.oWins,
        draws: a.draws + b.draws,
        totalMoves: a.totalMoves + b.totalMoves,
        totalDurationSeconds: a.totalDurationSeconds + b.totalDurationSeconds,
        xWinStreak: a.xWinStreak > b.xWinStreak ? a.xWinStreak : b.xWinStreak,
        oWinStreak: a.oWinStreak > b.oWinStreak ? a.oWinStreak : b.oWinStreak,
        xBestStreak: a.xBestStreak > b.xBestStreak
            ? a.xBestStreak
            : b.xBestStreak,
        oBestStreak: a.oBestStreak > b.oBestStreak
            ? a.oBestStreak
            : b.oBestStreak,
        updatedAt: a.updatedAt.isAfter(b.updatedAt) ? a.updatedAt : b.updatedAt,
      ),
    );
  }

  Future<void> resetAllStatistics() async {
    await _database.resetStatistics();
  }

  Future<void> resetStatisticsForBoardSize(BoardSize boardSize) async {
    throw UnimplementedError(
      'Per-board-size reset not yet implemented. Use resetAllStatistics().',
    );
  }
}
