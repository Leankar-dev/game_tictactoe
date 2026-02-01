import '../datasources/local/database.dart';
import '../models/models.dart';
import '../../domain/entities/entities.dart';
import '../../domain/enums/enums.dart';

class GameRepository {
  final AppDatabase _database;

  const GameRepository(this._database);

  Future<void> saveGame(GameEntity game) async {
    if (!game.isGameOver) {
      throw ArgumentError('Cannot save an incomplete game');
    }

    final model = GameModel.fromEntity(game);
    await _database.insertGame(model.toCompanion());

    final winner = _statusToWinnerString(game.status);
    await _database.updateStatisticsAfterGame(
      boardSize: game.boardSize == BoardSize.classic ? 'classic' : 'extended',
      gameMode: game.mode == GameMode.playerVsPlayer ? 'pvp' : 'pvc',
      winner: winner,
      movesCount: game.moveCount,
      durationSeconds: game.updatedAt.difference(game.createdAt).inSeconds,
    );
  }

  Future<List<GameModel>> getAllGames() async {
    final records = await _database.getAllGames();
    return records.map(GameModel.fromRecord).toList();
  }

  Future<List<GameModel>> getGamesByBoardSize(BoardSize boardSize) async {
    final sizeString = boardSize == BoardSize.classic ? 'classic' : 'extended';
    final records = await _database.getGamesByBoardSize(sizeString);
    return records.map(GameModel.fromRecord).toList();
  }

  Future<List<GameModel>> getGamesByGameMode(GameMode gameMode) async {
    final modeString = gameMode == GameMode.playerVsPlayer ? 'pvp' : 'pvc';
    final records = await _database.getGamesByGameMode(modeString);
    return records.map(GameModel.fromRecord).toList();
  }

  Future<List<GameModel>> getRecentGames({int limit = 10}) async {
    final records = await _database.getRecentGames(limit: limit);
    return records.map(GameModel.fromRecord).toList();
  }

  Future<GameModel?> getGameById(String id) async {
    final record = await _database.getGameById(id);
    return record != null ? GameModel.fromRecord(record) : null;
  }

  Future<bool> deleteGame(String id) async {
    final rowsAffected = await _database.deleteGame(id);
    return rowsAffected > 0;
  }

  Future<void> deleteAllGames() async {
    await _database.deleteAllGames();
  }

  Future<int> getGameCount() async {
    return _database.countGames();
  }

  String _statusToWinnerString(GameStatus status) {
    switch (status) {
      case GameStatus.xWins:
        return 'x';
      case GameStatus.oWins:
        return 'o';
      case GameStatus.draw:
        return 'draw';
      case GameStatus.playing:
        return 'none';
    }
  }
}
