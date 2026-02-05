import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/data/models/game_model.dart';
import 'package:game_tictactoe/domain/entities/entities.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';

void main() {
  group('GameModel', () {
    group('fromEntity', () {
      test('should convert GameEntity to GameModel', () {
        final entity = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        );

        final model = GameModel.fromEntity(entity);

        expect(model.id, entity.id);
        expect(model.boardSize, BoardSize.classic);
        expect(model.gameMode, GameMode.playerVsPlayer);
        expect(model.status, GameStatus.playing);
        expect(model.movesCount, 0);
        expect(model.moveHistory, isEmpty);
      });

      test('should convert game with moves', () {
        final move = MoveEntity.create(
          row: 0,
          col: 0,
          player: PlayerType.x,
          moveNumber: 1,
        );

        final entity =
            GameEntity.newGame(
              boardSize: BoardSize.classic,
              mode: GameMode.playerVsCpu,
            ).copyWith(
              moveHistory: [move],
              board: BoardEntity.empty(
                BoardSize.classic,
              ).withMove(0, 0, PlayerType.x),
            );

        final model = GameModel.fromEntity(entity);

        expect(model.movesCount, 1);
        expect(model.moveHistory.length, 1);
        expect(model.moveHistory.first.row, 0);
        expect(model.moveHistory.first.col, 0);
      });

      test('should convert completed game', () {
        final entity = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        ).copyWith(status: GameStatus.xWins);

        final model = GameModel.fromEntity(entity);

        expect(model.status, GameStatus.xWins);
        expect(model.completedAt, isNotNull);
      });
    });

    group('toEntity', () {
      test('should convert GameModel back to GameEntity', () {
        final originalEntity = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsPlayer,
        );

        final model = GameModel.fromEntity(originalEntity);
        final convertedEntity = model.toEntity();

        expect(convertedEntity.id, originalEntity.id);
        expect(convertedEntity.boardSize, originalEntity.boardSize);
        expect(convertedEntity.mode, originalEntity.mode);
      });

      test('should reconstruct board from move history', () {
        final move1 = MoveModel(
          row: 0,
          col: 0,
          player: PlayerType.x,
          moveNumber: 1,
        );
        final move2 = MoveModel(
          row: 1,
          col: 1,
          player: PlayerType.o,
          moveNumber: 2,
        );

        final model = GameModel(
          id: 'test-id',
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
          status: GameStatus.playing,
          movesCount: 2,
          durationSeconds: 0,
          moveHistory: [move1, move2],
          createdAt: DateTime.now(),
        );

        final entity = model.toEntity();

        expect(entity.board.getCell(0, 0), PlayerType.x);
        expect(entity.board.getCell(1, 1), PlayerType.o);
        expect(entity.board.emptyCellCount, 7);
      });
    });

    group('toCompanion', () {
      test('should create valid companion for database', () {
        final model = GameModel(
          id: 'test-id',
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
          status: GameStatus.xWins,
          movesCount: 5,
          durationSeconds: 60,
          moveHistory: [],
          createdAt: DateTime(2024, 1, 1),
          completedAt: DateTime(2024, 1, 1, 0, 1),
        );

        final companion = model.toCompanion();

        expect(companion.id.value, 'test-id');
        expect(companion.boardSize.value, 'classic');
        expect(companion.gameMode.value, 'pvp');
        expect(companion.winner.value, 'x');
        expect(companion.movesCount.value, 5);
      });
    });
  });

  group('MoveModel', () {
    group('fromJson', () {
      test('should parse JSON correctly', () {
        final json = {
          'row': 1,
          'col': 2,
          'player': 'X',
          'moveNumber': 3,
          'timestamp': '2024-01-01T00:00:00.000',
        };

        final model = MoveModel.fromJson(json);

        expect(model.row, 1);
        expect(model.col, 2);
        expect(model.player, PlayerType.x);
        expect(model.moveNumber, 3);
        expect(model.timestamp, isNotNull);
      });

      test('should handle missing timestamp', () {
        final json = {'row': 0, 'col': 0, 'player': 'O', 'moveNumber': 1};

        final model = MoveModel.fromJson(json);

        expect(model.timestamp, isNull);
      });
    });

    group('toJson', () {
      test('should convert to JSON correctly', () {
        final model = MoveModel(
          row: 1,
          col: 2,
          player: PlayerType.x,
          moveNumber: 3,
          timestamp: DateTime(2024, 1, 1),
        );

        final json = model.toJson();

        expect(json['row'], 1);
        expect(json['col'], 2);
        expect(json['player'], 'X');
        expect(json['moveNumber'], 3);
        expect(json['timestamp'], isNotNull);
      });

      test('should omit timestamp when null', () {
        final model = MoveModel(
          row: 0,
          col: 0,
          player: PlayerType.o,
          moveNumber: 1,
        );

        final json = model.toJson();

        expect(json.containsKey('timestamp'), false);
      });
    });

    group('fromEntity', () {
      test('should convert MoveEntity to MoveModel', () {
        final entity = MoveEntity.create(
          row: 1,
          col: 2,
          player: PlayerType.x,
          moveNumber: 3,
        );

        final model = MoveModel.fromEntity(entity);

        expect(model.row, entity.row);
        expect(model.col, entity.col);
        expect(model.player, entity.player);
        expect(model.moveNumber, entity.moveNumber);
        expect(model.timestamp, entity.timestamp);
      });
    });

    group('toEntity', () {
      test('should convert MoveModel to MoveEntity', () {
        final model = MoveModel(
          row: 1,
          col: 2,
          player: PlayerType.x,
          moveNumber: 3,
          timestamp: DateTime(2024, 1, 1),
        );

        final entity = model.toEntity();

        expect(entity.row, model.row);
        expect(entity.col, model.col);
        expect(entity.player, model.player);
        expect(entity.moveNumber, model.moveNumber);
        expect(entity.timestamp, model.timestamp);
      });
    });
  });
}
