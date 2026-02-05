import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/data/repositories/game_repository.dart';
import 'package:game_tictactoe/domain/entities/entities.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';

import 'test_database.dart';

void main() {
  late GameRepository repository;

  setUp(() async {
    final database = createTestDatabase();
    repository = GameRepository(database);
  });

  group('GameRepository', () {
    group('saveGame', () {
      test('should save a completed game', () async {
        final game = _createCompletedGame(winner: GameStatus.xWins);

        await repository.saveGame(game);

        final savedGames = await repository.getAllGames();
        expect(savedGames.length, 1);
        expect(savedGames.first.id, game.id);
        expect(savedGames.first.status, GameStatus.xWins);
      });

      test('should throw when saving incomplete game', () async {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        );

        expect(() => repository.saveGame(game), throwsArgumentError);
      });

      test('should save move history', () async {
        final game = _createCompletedGame(
          winner: GameStatus.xWins,
          movesCount: 5,
        );

        await repository.saveGame(game);

        final savedGames = await repository.getAllGames();
        expect(savedGames.first.moveHistory.length, 5);
      });
    });

    group('getAllGames', () {
      test('should return empty list when no games', () async {
        final games = await repository.getAllGames();
        expect(games, isEmpty);
      });

      test('should return all saved games', () async {
        final game1 = _createCompletedGame(winner: GameStatus.xWins);
        final game2 = _createCompletedGame(winner: GameStatus.oWins);
        final game3 = _createCompletedGame(winner: GameStatus.draw);

        await repository.saveGame(game1);
        await repository.saveGame(game2);
        await repository.saveGame(game3);

        final games = await repository.getAllGames();

        expect(games.length, 3);
        final gameIds = games.map((g) => g.id).toSet();
        expect(gameIds, contains(game1.id));
        expect(gameIds, contains(game2.id));
        expect(gameIds, contains(game3.id));
      });
    });

    group('getGamesByBoardSize', () {
      test('should filter by board size', () async {
        final classicGame = _createCompletedGame(
          winner: GameStatus.xWins,
          boardSize: BoardSize.classic,
        );
        final extendedGame = _createCompletedGame(
          winner: GameStatus.oWins,
          boardSize: BoardSize.extended,
        );

        await repository.saveGame(classicGame);
        await repository.saveGame(extendedGame);

        final classicGames = await repository.getGamesByBoardSize(
          BoardSize.classic,
        );
        final extendedGames = await repository.getGamesByBoardSize(
          BoardSize.extended,
        );

        expect(classicGames.length, 1);
        expect(classicGames.first.boardSize, BoardSize.classic);

        expect(extendedGames.length, 1);
        expect(extendedGames.first.boardSize, BoardSize.extended);
      });
    });

    group('getGamesByGameMode', () {
      test('should filter by game mode', () async {
        final pvpGame = _createCompletedGame(
          winner: GameStatus.xWins,
          gameMode: GameMode.playerVsPlayer,
        );
        final pvcGame = _createCompletedGame(
          winner: GameStatus.oWins,
          gameMode: GameMode.playerVsCpu,
        );

        await repository.saveGame(pvpGame);
        await repository.saveGame(pvcGame);

        final pvpGames = await repository.getGamesByGameMode(
          GameMode.playerVsPlayer,
        );
        final pvcGames = await repository.getGamesByGameMode(
          GameMode.playerVsCpu,
        );

        expect(pvpGames.length, 1);
        expect(pvpGames.first.gameMode, GameMode.playerVsPlayer);

        expect(pvcGames.length, 1);
        expect(pvcGames.first.gameMode, GameMode.playerVsCpu);
      });
    });

    group('getRecentGames', () {
      test('should respect limit parameter', () async {
        for (int i = 0; i < 15; i++) {
          await repository.saveGame(
            _createCompletedGame(winner: GameStatus.xWins),
          );
        }

        final recent5 = await repository.getRecentGames(limit: 5);
        final recent10 = await repository.getRecentGames(limit: 10);

        expect(recent5.length, 5);
        expect(recent10.length, 10);
      });
    });

    group('getGameById', () {
      test('should return game when exists', () async {
        final game = _createCompletedGame(winner: GameStatus.xWins);
        await repository.saveGame(game);

        final retrieved = await repository.getGameById(game.id);

        expect(retrieved, isNotNull);
        expect(retrieved!.id, game.id);
      });

      test('should return null when not exists', () async {
        final retrieved = await repository.getGameById('non-existent-id');
        expect(retrieved, isNull);
      });
    });

    group('deleteGame', () {
      test('should delete specific game', () async {
        final game1 = _createCompletedGame(winner: GameStatus.xWins);
        final game2 = _createCompletedGame(winner: GameStatus.oWins);

        await repository.saveGame(game1);
        await repository.saveGame(game2);

        final deleted = await repository.deleteGame(game1.id);
        final remaining = await repository.getAllGames();

        expect(deleted, true);
        expect(remaining.length, 1);
        expect(remaining.first.id, game2.id);
      });

      test('should return false when game not found', () async {
        final deleted = await repository.deleteGame('non-existent-id');
        expect(deleted, false);
      });
    });

    group('deleteAllGames', () {
      test('should delete all games', () async {
        await repository.saveGame(
          _createCompletedGame(winner: GameStatus.xWins),
        );
        await repository.saveGame(
          _createCompletedGame(winner: GameStatus.oWins),
        );
        await repository.saveGame(
          _createCompletedGame(winner: GameStatus.draw),
        );

        await repository.deleteAllGames();
        final games = await repository.getAllGames();

        expect(games, isEmpty);
      });
    });

    group('getGameCount', () {
      test('should return correct count', () async {
        expect(await repository.getGameCount(), 0);

        await repository.saveGame(
          _createCompletedGame(winner: GameStatus.xWins),
        );
        expect(await repository.getGameCount(), 1);

        await repository.saveGame(
          _createCompletedGame(winner: GameStatus.oWins),
        );
        expect(await repository.getGameCount(), 2);
      });
    });
  });
}

GameEntity _createCompletedGame({
  required GameStatus winner,
  BoardSize boardSize = BoardSize.classic,
  GameMode gameMode = GameMode.playerVsPlayer,
  int movesCount = 5,
}) {
  var game = GameEntity.newGame(boardSize: boardSize, mode: gameMode);

  final moves = <MoveEntity>[];
  for (int i = 0; i < movesCount; i++) {
    final row = i ~/ boardSize.size;
    final col = i % boardSize.size;
    final player = i.isEven ? PlayerType.x : PlayerType.o;
    moves.add(
      MoveEntity.create(row: row, col: col, player: player, moveNumber: i + 1),
    );
  }

  var board = BoardEntity.empty(boardSize);
  for (final move in moves) {
    board = board.withMove(move.row, move.col, move.player);
  }

  return game.copyWith(board: board, status: winner, moveHistory: moves);
}
