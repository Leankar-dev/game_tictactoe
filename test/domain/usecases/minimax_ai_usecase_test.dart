import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/domain/entities/entities.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';
import 'package:game_tictactoe/domain/usecases/ai_move_usecase.dart';

void main() {
  group('MinimaxAiUseCase', () {
    late MinimaxAiUseCase useCase;

    setUp(() {
      useCase = const MinimaxAiUseCase();
    });

    group('basic behavior', () {
      test('should return AiMoveNotFound when game is over', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        ).copyWith(status: GameStatus.xWins);

        final result = useCase(game);

        expect(result, isA<AiMoveNotFound>());
      });

      test('should return AiMoveNotFound when not AI turn', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        );

        final result = useCase(game, aiPlayer: PlayerType.o);

        expect(result, isA<AiMoveNotFound>());
      });

      test('should return valid move for empty board', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        );

        final result = useCase(game, aiPlayer: PlayerType.x);

        expect(result, isA<AiMoveFound>());
        final found = result as AiMoveFound;
        expect(found.row, greaterThanOrEqualTo(0));
        expect(found.row, lessThan(3));
        expect(found.col, greaterThanOrEqualTo(0));
        expect(found.col, lessThan(3));
      });
    });

    group('winning moves', () {
      test('should find winning move in row', () {
        final moves = [
          MoveEntity.create(
            row: 0,
            col: 0,
            player: PlayerType.x,
            moveNumber: 1,
          ),
          MoveEntity.create(
            row: 1,
            col: 0,
            player: PlayerType.o,
            moveNumber: 2,
          ),
          MoveEntity.create(
            row: 0,
            col: 1,
            player: PlayerType.x,
            moveNumber: 3,
          ),
          MoveEntity.create(
            row: 1,
            col: 1,
            player: PlayerType.o,
            moveNumber: 4,
          ),
        ];

        var game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        );

        game = game.copyWith(
          board: game.board
              .withMove(0, 0, PlayerType.x)
              .withMove(0, 1, PlayerType.x)
              .withMove(1, 0, PlayerType.o)
              .withMove(1, 1, PlayerType.o),
          currentTurn: PlayerType.x,
          moveHistory: moves,
        );

        final result = useCase(game, aiPlayer: PlayerType.x);

        expect(result, isA<AiMoveFound>());
        final found = result as AiMoveFound;
        expect(found.row, 0);
        expect(found.col, 2);
      });

      test('should find winning move in column', () {
        final moves = [
          MoveEntity.create(
            row: 0,
            col: 0,
            player: PlayerType.x,
            moveNumber: 1,
          ),
          MoveEntity.create(
            row: 0,
            col: 1,
            player: PlayerType.o,
            moveNumber: 2,
          ),
          MoveEntity.create(
            row: 1,
            col: 0,
            player: PlayerType.x,
            moveNumber: 3,
          ),
          MoveEntity.create(
            row: 1,
            col: 1,
            player: PlayerType.o,
            moveNumber: 4,
          ),
        ];

        var game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        );

        game = game.copyWith(
          board: game.board
              .withMove(0, 0, PlayerType.x)
              .withMove(1, 0, PlayerType.x)
              .withMove(0, 1, PlayerType.o)
              .withMove(1, 1, PlayerType.o),
          currentTurn: PlayerType.x,
          moveHistory: moves,
        );

        final result = useCase(game, aiPlayer: PlayerType.x);

        expect(result, isA<AiMoveFound>());
        final found = result as AiMoveFound;
        expect(found.row, 2);
        expect(found.col, 0);
      });

      test('should find winning move in diagonal', () {
        final moves = [
          MoveEntity.create(
            row: 0,
            col: 0,
            player: PlayerType.x,
            moveNumber: 1,
          ),
          MoveEntity.create(
            row: 0,
            col: 1,
            player: PlayerType.o,
            moveNumber: 2,
          ),
          MoveEntity.create(
            row: 1,
            col: 1,
            player: PlayerType.x,
            moveNumber: 3,
          ),
          MoveEntity.create(
            row: 0,
            col: 2,
            player: PlayerType.o,
            moveNumber: 4,
          ),
        ];

        var game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        );

        game = game.copyWith(
          board: game.board
              .withMove(0, 0, PlayerType.x)
              .withMove(1, 1, PlayerType.x)
              .withMove(0, 1, PlayerType.o)
              .withMove(0, 2, PlayerType.o),
          currentTurn: PlayerType.x,
          moveHistory: moves,
        );

        final result = useCase(game, aiPlayer: PlayerType.x);

        expect(result, isA<AiMoveFound>());
        final found = result as AiMoveFound;
        expect(found.row, 2);
        expect(found.col, 2);
      });
    });

    group('blocking moves', () {
      test('should block opponent winning move', () {
        final moves = [
          MoveEntity.create(
            row: 0,
            col: 0,
            player: PlayerType.x,
            moveNumber: 1,
          ),
          MoveEntity.create(
            row: 1,
            col: 1,
            player: PlayerType.o,
            moveNumber: 2,
          ),
          MoveEntity.create(
            row: 0,
            col: 1,
            player: PlayerType.x,
            moveNumber: 3,
          ),
        ];

        var game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        );

        game = game.copyWith(
          board: game.board
              .withMove(0, 0, PlayerType.x)
              .withMove(0, 1, PlayerType.x)
              .withMove(1, 1, PlayerType.o),
          currentTurn: PlayerType.o,
          moveHistory: moves,
        );

        final result = useCase(game, aiPlayer: PlayerType.o);

        expect(result, isA<AiMoveFound>());
        final found = result as AiMoveFound;
        expect(found.row, 0);
        expect(found.col, 2);
      });
    });

    group('optimal play', () {
      test('should never lose with optimal play', () {
        var game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        );

        game = game.copyWith(
          board: game.board.withMove(1, 1, PlayerType.x),
          currentTurn: PlayerType.o,
        );

        final result = useCase(game, aiPlayer: PlayerType.o);

        expect(result, isA<AiMoveFound>());
        final found = result as AiMoveFound;
        final isCorner =
            (found.row == 0 || found.row == 2) &&
            (found.col == 0 || found.col == 2);
        expect(isCorner, true);
      });

      test('should take center or corner on first move', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        );

        final result = useCase(game, aiPlayer: PlayerType.x);

        expect(result, isA<AiMoveFound>());
        final found = result as AiMoveFound;
        final isCorner =
            (found.row == 0 || found.row == 2) &&
            (found.col == 0 || found.col == 2);
        final isCenter = found.row == 1 && found.col == 1;
        expect(isCorner || isCenter, true);
      });
    });

    group('depth limit', () {
      test('should respect max depth parameter', () {
        final game = GameEntity.newGame(
          boardSize: BoardSize.classic,
          mode: GameMode.playerVsCpu,
        );

        final result = useCase(game, aiPlayer: PlayerType.x, maxDepth: 1);

        expect(result, isA<AiMoveFound>());
      });
    });
  });
}
