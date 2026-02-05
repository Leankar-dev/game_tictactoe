import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/domain/entities/entities.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';

void main() {
  group('GameEntity', () {
    group('newGame factory', () {
      test('should create new PvP game with correct defaults', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        );

        expect(game.id, isNotEmpty);
        expect(game.boardSize, BoardSize.classic);
        expect(game.mode, GameMode.playerVsPlayer);
        expect(game.currentTurn, PlayerType.x);
        expect(game.status, GameStatus.playing);
        expect(game.moveHistory, isEmpty);
        expect(game.winningCells, isNull);
        expect(game.playerX.isCpu, false);
        expect(game.playerO.isCpu, false);
      });

      test('should create new PvC game with CPU as player O', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        );

        expect(game.mode, GameMode.playerVsCpu);
        expect(game.playerX.isCpu, false);
        expect(game.playerO.isCpu, true);
      });

      test('should create extended board game', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.extended,
          mode: GameMode.playerVsPlayer,
        );

        expect(game.boardSize, BoardSize.extended);
        expect(game.board.emptyCellCount, 36);
      });

      test('should accept custom player names', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
          playerX: PlayerEntity.playerX(name: 'Alice'),
          playerO: PlayerEntity.playerO(name: 'Bob'),
        );

        expect(game.playerX.name, 'Alice');
        expect(game.playerO.name, 'Bob');
      });
    });

    group('currentPlayer', () {
      test('should return playerX when turn is X', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        );

        expect(game.currentPlayer, game.playerX);
      });

      test('should return playerO when turn is O', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        ).copyWith(currentTurn: PlayerType.o);

        expect(game.currentPlayer, game.playerO);
      });
    });

    group('isCpuTurn', () {
      test('should return false for PvP game', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        );

        expect(game.isCpuTurn, false);
      });

      test('should return false when X turn in PvC game', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        );

        expect(game.isCpuTurn, false);
      });

      test('should return true when O turn in PvC game', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        ).copyWith(currentTurn: PlayerType.o);

        expect(game.isCpuTurn, true);
      });
    });

    group('moveCount', () {
      test('should return 0 for new game', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        );

        expect(game.moveCount, 0);
      });

      test('should return correct count with moves', () {
        final move1 = MoveEntity.create(
          row: 0,
          col: 0,
          player: PlayerType.x,
          moveNumber: 1,
        );
        final move2 = MoveEntity.create(
          row: 1,
          col: 1,
          player: PlayerType.o,
          moveNumber: 2,
        );

        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        ).copyWith(moveHistory: [move1, move2]);

        expect(game.moveCount, 2);
      });
    });

    group('isGameOver', () {
      test('should return false for playing status', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        );

        expect(game.isGameOver, false);
      });

      test('should return true for xWins status', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        ).copyWith(status: GameStatus.xWins);

        expect(game.isGameOver, true);
      });

      test('should return true for draw status', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        ).copyWith(status: GameStatus.draw);

        expect(game.isGameOver, true);
      });
    });

    group('hasWinner', () {
      test('should return false for playing status', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        );

        expect(game.hasWinner, false);
      });

      test('should return false for draw status', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        ).copyWith(status: GameStatus.draw);

        expect(game.hasWinner, false);
      });

      test('should return true for xWins status', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        ).copyWith(status: GameStatus.xWins);

        expect(game.hasWinner, true);
      });
    });

    group('lastMove', () {
      test('should return null for new game', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        );

        expect(game.lastMove, isNull);
      });

      test('should return last move when moves exist', () {
        final move1 = MoveEntity.create(
          row: 0,
          col: 0,
          player: PlayerType.x,
          moveNumber: 1,
        );
        final move2 = MoveEntity.create(
          row: 1,
          col: 1,
          player: PlayerType.o,
          moveNumber: 2,
        );

        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        ).copyWith(moveHistory: [move1, move2]);

        expect(game.lastMove, move2);
      });
    });

    group('copyWith', () {
      test('should create copy with updated fields', () {
        final original = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        );

        final updated = original.copyWith(
          currentTurn: PlayerType.o,
          status: GameStatus.xWins,
        );

        expect(updated.currentTurn, PlayerType.o);
        expect(updated.status, GameStatus.xWins);
        expect(updated.id, original.id);
        expect(updated.boardSize, original.boardSize);
      });

      test('should preserve fields not updated', () {
        final original = GameEntity.newGame(
          boardSize: BoardSize.extended,
          mode: GameMode.playerVsCpu,
        );

        final updated = original.copyWith(status: GameStatus.draw);

        expect(updated.boardSize, BoardSize.extended);
        expect(updated.mode, GameMode.playerVsCpu);
        expect(updated.status, GameStatus.draw);
      });
    });
  });
}
