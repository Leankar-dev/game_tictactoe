import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/domain/entities/board_entity.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';

void main() {
  group('BoardEntity', () {
    group('empty factory', () {
      test('should create 3x3 empty board for classic', () {
        final board = BoardEntity.empty(BoardSize.classic);

        expect(board.size, BoardSize.classic);
        expect(board.emptyCellCount, 9);
        expect(board.isFull, false);
      });

      test('should create 6x6 empty board for extended', () {
        final board = BoardEntity.empty(BoardSize.extended);

        expect(board.size, BoardSize.extended);
        expect(board.emptyCellCount, 36);
      });
    });

    group('getCell', () {
      test('should return correct player at position', () {
        final board = BoardEntity.empty(
          BoardSize.classic,
        ).withMove(0, 0, PlayerType.x);

        expect(board.getCell(0, 0), PlayerType.x);
        expect(board.getCell(0, 1), PlayerType.none);
      });

      test('should throw RangeError for out of bounds', () {
        final board = BoardEntity.empty(BoardSize.classic);

        expect(() => board.getCell(-1, 0), throwsRangeError);
        expect(() => board.getCell(0, 3), throwsRangeError);
      });
    });

    group('withMove', () {
      test('should return new board with move applied', () {
        final original = BoardEntity.empty(BoardSize.classic);
        final updated = original.withMove(1, 1, PlayerType.x);

        expect(original.getCell(1, 1), PlayerType.none);
        expect(updated.getCell(1, 1), PlayerType.x);
        expect(original != updated, true);
      });

      test('should maintain immutability', () {
        final board1 = BoardEntity.empty(BoardSize.classic);
        final board2 = board1.withMove(0, 0, PlayerType.x);
        final board3 = board2.withMove(1, 1, PlayerType.o);

        expect(board1.emptyCellCount, 9);
        expect(board2.emptyCellCount, 8);
        expect(board3.emptyCellCount, 7);
      });
    });

    group('isFull', () {
      test('should return false for non-full board', () {
        final board = BoardEntity.empty(
          BoardSize.classic,
        ).withMove(0, 0, PlayerType.x);

        expect(board.isFull, false);
      });

      test('should return true when board is full', () {
        var board = BoardEntity.empty(BoardSize.classic);
        int moveCount = 0;

        for (int r = 0; r < 3; r++) {
          for (int c = 0; c < 3; c++) {
            board = board.withMove(
              r,
              c,
              moveCount.isEven ? PlayerType.x : PlayerType.o,
            );
            moveCount++;
          }
        }

        expect(board.isFull, true);
      });
    });

    group('emptyCells', () {
      test('should return all positions for empty board', () {
        final board = BoardEntity.empty(BoardSize.classic);
        final emptyCells = board.emptyCells;

        expect(emptyCells.length, 9);
      });

      test('should exclude occupied positions', () {
        final board = BoardEntity.empty(
          BoardSize.classic,
        ).withMove(0, 0, PlayerType.x).withMove(1, 1, PlayerType.o);

        final emptyCells = board.emptyCells;

        expect(emptyCells.length, 7);
        expect(emptyCells.any((c) => c.row == 0 && c.col == 0), false);
        expect(emptyCells.any((c) => c.row == 1 && c.col == 1), false);
      });
    });

    group('isCellEmpty', () {
      test('should return true for empty cell', () {
        final board = BoardEntity.empty(BoardSize.classic);

        expect(board.isCellEmpty(0, 0), true);
      });

      test('should return false for occupied cell', () {
        final board = BoardEntity.empty(
          BoardSize.classic,
        ).withMove(0, 0, PlayerType.x);

        expect(board.isCellEmpty(0, 0), false);
      });
    });

    group('moveCount', () {
      test('should return 0 for empty board', () {
        final board = BoardEntity.empty(BoardSize.classic);

        expect(board.moveCount, 0);
      });

      test('should return correct count after moves', () {
        final board = BoardEntity.empty(BoardSize.classic)
            .withMove(0, 0, PlayerType.x)
            .withMove(1, 1, PlayerType.o)
            .withMove(2, 2, PlayerType.x);

        expect(board.moveCount, 3);
      });
    });

    group('equality', () {
      test('should be equal for same state', () {
        final board1 = BoardEntity.empty(
          BoardSize.classic,
        ).withMove(0, 0, PlayerType.x);
        final board2 = BoardEntity.empty(
          BoardSize.classic,
        ).withMove(0, 0, PlayerType.x);

        expect(board1, equals(board2));
      });

      test('should not be equal for different states', () {
        final board1 = BoardEntity.empty(
          BoardSize.classic,
        ).withMove(0, 0, PlayerType.x);
        final board2 = BoardEntity.empty(
          BoardSize.classic,
        ).withMove(0, 0, PlayerType.o);

        expect(board1, isNot(equals(board2)));
      });
    });

    group('fromCells factory', () {
      test('should create board from existing cells', () {
        final cells = [
          [PlayerType.x, PlayerType.none, PlayerType.none],
          [PlayerType.none, PlayerType.o, PlayerType.none],
          [PlayerType.none, PlayerType.none, PlayerType.x],
        ];

        final board = BoardEntity.fromCells(cells, BoardSize.classic);

        expect(board.getCell(0, 0), PlayerType.x);
        expect(board.getCell(1, 1), PlayerType.o);
        expect(board.getCell(2, 2), PlayerType.x);
        expect(board.emptyCellCount, 6);
      });
    });
  });
}
