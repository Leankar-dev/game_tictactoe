import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/domain/entities/move_entity.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';

void main() {
  group('MoveEntity', () {
    group('create factory', () {
      test('should create move with correct properties', () {
        final move = MoveEntity.create(
          row: 1,
          col: 2,
          player: PlayerType.x,
          moveNumber: 1,
        );

        expect(move.row, 1);
        expect(move.col, 2);
        expect(move.player, PlayerType.x);
        expect(move.moveNumber, 1);
        expect(move.timestamp, isNotNull);
      });

      test('should set timestamp automatically', () {
        final before = DateTime.now();
        final move = MoveEntity.create(
          row: 0,
          col: 0,
          player: PlayerType.o,
          moveNumber: 2,
        );
        final after = DateTime.now();

        expect(
          move.timestamp.isAfter(before) ||
              move.timestamp.isAtSameMomentAs(before),
          true,
        );
        expect(
          move.timestamp.isBefore(after) ||
              move.timestamp.isAtSameMomentAs(after),
          true,
        );
      });
    });

    group('positionString', () {
      test('should return correct position format', () {
        final move = MoveEntity.create(
          row: 1,
          col: 2,
          player: PlayerType.x,
          moveNumber: 1,
        );

        expect(move.positionString, '(1, 2)');
      });

      test('should handle zero positions', () {
        final move = MoveEntity.create(
          row: 0,
          col: 0,
          player: PlayerType.x,
          moveNumber: 1,
        );

        expect(move.positionString, '(0, 0)');
      });
    });

    group('copyWith', () {
      test('should create copy with updated fields', () {
        final original = MoveEntity.create(
          row: 0,
          col: 0,
          player: PlayerType.x,
          moveNumber: 1,
        );

        final updated = original.copyWith(row: 1, col: 2);

        expect(updated.row, 1);
        expect(updated.col, 2);
        expect(updated.player, original.player);
        expect(updated.moveNumber, original.moveNumber);
      });

      test('should preserve timestamp when not updated', () {
        final original = MoveEntity.create(
          row: 0,
          col: 0,
          player: PlayerType.x,
          moveNumber: 1,
        );

        final updated = original.copyWith(player: PlayerType.o);

        expect(updated.timestamp, original.timestamp);
      });

      test('should update timestamp when specified', () {
        final original = MoveEntity.create(
          row: 0,
          col: 0,
          player: PlayerType.x,
          moveNumber: 1,
        );

        final newTimestamp = DateTime(2024, 1, 1);
        final updated = original.copyWith(timestamp: newTimestamp);

        expect(updated.timestamp, newTimestamp);
      });
    });

    group('equality', () {
      test('should be equal for same properties', () {
        final timestamp = DateTime(2024, 1, 1);
        final move1 = MoveEntity(
          row: 1,
          col: 1,
          player: PlayerType.x,
          moveNumber: 1,
          timestamp: timestamp,
        );
        final move2 = MoveEntity(
          row: 1,
          col: 1,
          player: PlayerType.x,
          moveNumber: 1,
          timestamp: timestamp,
        );

        expect(move1, equals(move2));
      });

      test('should not be equal for different positions', () {
        final timestamp = DateTime(2024, 1, 1);
        final move1 = MoveEntity(
          row: 0,
          col: 0,
          player: PlayerType.x,
          moveNumber: 1,
          timestamp: timestamp,
        );
        final move2 = MoveEntity(
          row: 1,
          col: 1,
          player: PlayerType.x,
          moveNumber: 1,
          timestamp: timestamp,
        );

        expect(move1, isNot(equals(move2)));
      });

      test('should not be equal for different players', () {
        final timestamp = DateTime(2024, 1, 1);
        final move1 = MoveEntity(
          row: 0,
          col: 0,
          player: PlayerType.x,
          moveNumber: 1,
          timestamp: timestamp,
        );
        final move2 = MoveEntity(
          row: 0,
          col: 0,
          player: PlayerType.o,
          moveNumber: 1,
          timestamp: timestamp,
        );

        expect(move1, isNot(equals(move2)));
      });
    });

    group('toString', () {
      test('should return readable representation', () {
        final move = MoveEntity.create(
          row: 1,
          col: 2,
          player: PlayerType.x,
          moveNumber: 3,
        );

        expect(move.toString(), contains('row: 1'));
        expect(move.toString(), contains('col: 2'));
        expect(move.toString(), contains('X'));
        expect(move.toString(), contains('moveNumber: 3'));
      });
    });
  });
}
