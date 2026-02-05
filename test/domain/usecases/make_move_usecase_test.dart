import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/domain/entities/entities.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';
import 'package:game_tictactoe/domain/usecases/make_move_usecase.dart';

void main() {
  late MakeMoveUseCase useCase;

  setUp(() {
    useCase = const MakeMoveUseCase();
  });

  group('MakeMoveUseCase - Valid moves', () {
    test('should make valid move on empty cell', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      );

      final result = useCase(game, row: 0, col: 0);

      expect(result, isA<MakeMoveSuccess>());
      final success = result as MakeMoveSuccess;
      expect(success.game.board.getCell(0, 0), PlayerType.x);
      expect(success.game.currentTurn, PlayerType.o);
      expect(success.game.moveHistory.length, 1);
      expect(success.move.row, 0);
      expect(success.move.col, 0);
      expect(success.move.player, PlayerType.x);
    });

    test('should alternate turns correctly', () {
      var game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      );

      var result = useCase(game, row: 0, col: 0) as MakeMoveSuccess;
      expect(result.game.currentTurn, PlayerType.o);

      result = useCase(result.game, row: 1, col: 1) as MakeMoveSuccess;
      expect(result.game.currentTurn, PlayerType.x);

      result = useCase(result.game, row: 0, col: 1) as MakeMoveSuccess;
      expect(result.game.currentTurn, PlayerType.o);
    });

    test('should detect winning move', () {
      final board = BoardEntity.empty(
        BoardSize.classic,
      ).withMove(0, 0, PlayerType.x).withMove(0, 1, PlayerType.x);
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      ).copyWith(board: board, currentTurn: PlayerType.x);

      final result = useCase(game, row: 0, col: 2) as MakeMoveSuccess;

      expect(result.isWinningMove, true);
      expect(result.game.status, GameStatus.xWins);
      expect(result.winnerCheck.winningCells.length, 3);
    });

    test('should detect draw', () {
      final board = BoardEntity.empty(BoardSize.classic)
          .withMove(0, 0, PlayerType.x)
          .withMove(0, 1, PlayerType.o)
          .withMove(0, 2, PlayerType.x)
          .withMove(1, 0, PlayerType.x)
          .withMove(1, 1, PlayerType.o)
          .withMove(1, 2, PlayerType.o)
          .withMove(2, 0, PlayerType.o)
          .withMove(2, 1, PlayerType.x);
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      ).copyWith(board: board, currentTurn: PlayerType.x);

      final result = useCase(game, row: 2, col: 2) as MakeMoveSuccess;

      expect(result.game.status, GameStatus.draw);
      expect(result.gameEnded, true);
      expect(result.isWinningMove, false);
    });
  });

  group('MakeMoveUseCase - Invalid moves', () {
    test('should fail when game is over', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      ).copyWith(status: GameStatus.xWins);

      final result = useCase(game, row: 0, col: 0);

      expect(result, isA<MakeMoveFailure>());
      final failure = result as MakeMoveFailure;
      expect(failure.error, MakeMoveError.gameOver);
    });

    test('should fail when cell is occupied', () {
      final board = BoardEntity.empty(
        BoardSize.classic,
      ).withMove(0, 0, PlayerType.x);
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      ).copyWith(board: board, currentTurn: PlayerType.o);

      final result = useCase(game, row: 0, col: 0);

      expect(result, isA<MakeMoveFailure>());
      final failure = result as MakeMoveFailure;
      expect(failure.error, MakeMoveError.cellOccupied);
    });

    test('should fail when not player turn', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      );

      final result = useCase(game, row: 0, col: 0, player: PlayerType.o);

      expect(result, isA<MakeMoveFailure>());
      final failure = result as MakeMoveFailure;
      expect(failure.error, MakeMoveError.notYourTurn);
    });

    test('should fail when position out of bounds', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      );

      final result = useCase(game, row: 5, col: 0);

      expect(result, isA<MakeMoveFailure>());
      final failure = result as MakeMoveFailure;
      expect(failure.error, MakeMoveError.outOfBounds);
    });

    test('should fail with negative position', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      );

      final result = useCase(game, row: -1, col: 0);

      expect(result, isA<MakeMoveFailure>());
      final failure = result as MakeMoveFailure;
      expect(failure.error, MakeMoveError.outOfBounds);
    });
  });

  group('MakeMoveUseCase - Helper methods', () {
    test('isValidMove should return true for valid move', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      );

      expect(useCase.isValidMove(game, 0, 0), true);
    });

    test('isValidMove should return false for occupied cell', () {
      final board = BoardEntity.empty(
        BoardSize.classic,
      ).withMove(0, 0, PlayerType.x);
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      ).copyWith(board: board);

      expect(useCase.isValidMove(game, 0, 0), false);
    });

    test('getValidMoves should return all empty cells', () {
      final board = BoardEntity.empty(
        BoardSize.classic,
      ).withMove(0, 0, PlayerType.x).withMove(1, 1, PlayerType.o);
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      ).copyWith(board: board);

      final validMoves = useCase.getValidMoves(game);

      expect(validMoves.length, 7);
      expect(validMoves, isNot(contains((row: 0, col: 0))));
      expect(validMoves, isNot(contains((row: 1, col: 1))));
    });

    test('getValidMoves should return empty list when game over', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      ).copyWith(status: GameStatus.xWins);

      final validMoves = useCase.getValidMoves(game);

      expect(validMoves, isEmpty);
    });
  });

  group('GameEntityMoveExtension', () {
    test('makeMove extension should work correctly', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      );

      final result = game.makeMove(0, 0);

      expect(result, isA<MakeMoveSuccess>());
    });
  });
}
