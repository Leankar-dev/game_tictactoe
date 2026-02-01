import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/domain/entities/board_entity.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';
import 'package:game_tictactoe/domain/usecases/check_winner_usecase.dart';

void main() {
  late CheckWinnerUseCase useCase;

  setUp(() {
    useCase = const CheckWinnerUseCase();
  });

  group('CheckWinnerUseCase - Classic 3x3', () {
    group('Horizontal wins', () {
      test('should detect X winning on top row', () {
        final board = BoardEntity.empty(BoardSize.classic)
            .withMove(0, 0, PlayerType.x)
            .withMove(0, 1, PlayerType.x)
            .withMove(0, 2, PlayerType.x);

        final result = useCase(board);

        expect(result.hasWinner, true);
        expect(result.winner, PlayerType.x);
        expect(result.winningCells.length, 3);
        expect(result.winningCells, contains((row: 0, col: 0)));
        expect(result.winningCells, contains((row: 0, col: 1)));
        expect(result.winningCells, contains((row: 0, col: 2)));
      });

      test('should detect O winning on middle row', () {
        final board = BoardEntity.empty(BoardSize.classic)
            .withMove(1, 0, PlayerType.o)
            .withMove(1, 1, PlayerType.o)
            .withMove(1, 2, PlayerType.o);

        final result = useCase(board);

        expect(result.hasWinner, true);
        expect(result.winner, PlayerType.o);
      });

      test('should detect X winning on bottom row', () {
        final board = BoardEntity.empty(BoardSize.classic)
            .withMove(2, 0, PlayerType.x)
            .withMove(2, 1, PlayerType.x)
            .withMove(2, 2, PlayerType.x);

        final result = useCase(board);

        expect(result.hasWinner, true);
        expect(result.winner, PlayerType.x);
      });
    });

    group('Vertical wins', () {
      test('should detect X winning on left column', () {
        final board = BoardEntity.empty(BoardSize.classic)
            .withMove(0, 0, PlayerType.x)
            .withMove(1, 0, PlayerType.x)
            .withMove(2, 0, PlayerType.x);

        final result = useCase(board);

        expect(result.hasWinner, true);
        expect(result.winner, PlayerType.x);
      });

      test('should detect O winning on middle column', () {
        final board = BoardEntity.empty(BoardSize.classic)
            .withMove(0, 1, PlayerType.o)
            .withMove(1, 1, PlayerType.o)
            .withMove(2, 1, PlayerType.o);

        final result = useCase(board);

        expect(result.hasWinner, true);
        expect(result.winner, PlayerType.o);
      });

      test('should detect X winning on right column', () {
        final board = BoardEntity.empty(BoardSize.classic)
            .withMove(0, 2, PlayerType.x)
            .withMove(1, 2, PlayerType.x)
            .withMove(2, 2, PlayerType.x);

        final result = useCase(board);

        expect(result.hasWinner, true);
        expect(result.winner, PlayerType.x);
      });
    });

    group('Diagonal wins', () {
      test('should detect X winning on main diagonal', () {
        final board = BoardEntity.empty(BoardSize.classic)
            .withMove(0, 0, PlayerType.x)
            .withMove(1, 1, PlayerType.x)
            .withMove(2, 2, PlayerType.x);

        final result = useCase(board);

        expect(result.hasWinner, true);
        expect(result.winner, PlayerType.x);
      });

      test('should detect O winning on anti-diagonal', () {
        final board = BoardEntity.empty(BoardSize.classic)
            .withMove(0, 2, PlayerType.o)
            .withMove(1, 1, PlayerType.o)
            .withMove(2, 0, PlayerType.o);

        final result = useCase(board);

        expect(result.hasWinner, true);
        expect(result.winner, PlayerType.o);
      });
    });

    group('Draw scenarios', () {
      test('should detect draw when board is full with no winner', () {
        final board = BoardEntity.empty(BoardSize.classic)
            .withMove(0, 0, PlayerType.x)
            .withMove(0, 1, PlayerType.o)
            .withMove(0, 2, PlayerType.x)
            .withMove(1, 0, PlayerType.x)
            .withMove(1, 1, PlayerType.o)
            .withMove(1, 2, PlayerType.o)
            .withMove(2, 0, PlayerType.o)
            .withMove(2, 1, PlayerType.x)
            .withMove(2, 2, PlayerType.x);

        final result = useCase(board);

        expect(result.hasWinner, false);
        expect(result.isDraw, true);
        expect(result.isGameOver, true);
      });
    });

    group('No winner scenarios', () {
      test('should return no winner for empty board', () {
        final board = BoardEntity.empty(BoardSize.classic);

        final result = useCase(board);

        expect(result.hasWinner, false);
        expect(result.isDraw, false);
        expect(result.isGameOver, false);
      });

      test('should return no winner for game in progress', () {
        final board = BoardEntity.empty(BoardSize.classic)
            .withMove(0, 0, PlayerType.x)
            .withMove(1, 1, PlayerType.o);

        final result = useCase(board);

        expect(result.hasWinner, false);
        expect(result.isDraw, false);
      });
    });
  });

  group('CheckWinnerUseCase - Extended 6x6', () {
    test('should require 4 in a row to win', () {
      final board3 = BoardEntity.empty(BoardSize.extended)
          .withMove(0, 0, PlayerType.x)
          .withMove(0, 1, PlayerType.x)
          .withMove(0, 2, PlayerType.x);

      final result3 = useCase(board3);
      expect(result3.hasWinner, false);

      final board4 = board3.withMove(0, 3, PlayerType.x);

      final result4 = useCase(board4);
      expect(result4.hasWinner, true);
      expect(result4.winner, PlayerType.x);
      expect(result4.winningCells.length, 4);
    });

    test('should detect diagonal win in 6x6', () {
      final board = BoardEntity.empty(BoardSize.extended)
          .withMove(0, 0, PlayerType.o)
          .withMove(1, 1, PlayerType.o)
          .withMove(2, 2, PlayerType.o)
          .withMove(3, 3, PlayerType.o);

      final result = useCase(board);

      expect(result.hasWinner, true);
      expect(result.winner, PlayerType.o);
    });
  });

  group('checkFromMove optimization', () {
    test('should find winner when checking from winning move', () {
      final board = BoardEntity.empty(BoardSize.classic)
          .withMove(0, 0, PlayerType.x)
          .withMove(0, 1, PlayerType.x)
          .withMove(0, 2, PlayerType.x);

      final result = useCase.checkFromMove(board, 0, 2);

      expect(result.hasWinner, true);
      expect(result.winner, PlayerType.x);
    });

    test('should not find winner when move does not complete a line', () {
      final board = BoardEntity.empty(BoardSize.classic)
          .withMove(0, 0, PlayerType.x)
          .withMove(0, 1, PlayerType.o)
          .withMove(0, 2, PlayerType.x);

      final result = useCase.checkFromMove(board, 0, 2);

      expect(result.hasWinner, false);
    });
  });

  group('WinnerCheckResult', () {
    test('toGameStatus should return correct status', () {
      expect(
        WinnerCheckResult.winner(PlayerType.x, []).toGameStatus(),
        GameStatus.xWins,
      );
      expect(
        WinnerCheckResult.winner(PlayerType.o, []).toGameStatus(),
        GameStatus.oWins,
      );
      expect(
        WinnerCheckResult.draw().toGameStatus(),
        GameStatus.draw,
      );
      expect(
        WinnerCheckResult.noWinner().toGameStatus(),
        GameStatus.playing,
      );
    });
  });
}
