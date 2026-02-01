import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:game_tictactoe/domain/entities/entities.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';
import 'package:game_tictactoe/domain/usecases/ai_move_usecase.dart';

class MockRandom extends Mock implements Random {}

void main() {
  late AiMoveUseCase useCase;
  late MockRandom mockRandom;

  setUp(() {
    mockRandom = MockRandom();
    useCase = AiMoveUseCase(random: mockRandom);
  });

  group('AiMoveUseCase - Priority 1: Winning moves', () {
    test('should choose winning move when available', () {
      final board = BoardEntity.empty(BoardSize.classic)
          .withMove(0, 0, PlayerType.o)
          .withMove(0, 1, PlayerType.o)
          .withMove(1, 0, PlayerType.x)
          .withMove(1, 1, PlayerType.x);
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsCpu,
      ).copyWith(board: board, currentTurn: PlayerType.o);

      final result = useCase(game);

      expect(result, isA<AiMoveFound>());
      final found = result as AiMoveFound;
      expect(found.row, 0);
      expect(found.col, 2);
      expect(found.reason, AiMoveReason.winningMove);
    });
  });

  group('AiMoveUseCase - Priority 2: Blocking moves', () {
    test('should block opponent winning move', () {
      final board = BoardEntity.empty(BoardSize.classic)
          .withMove(0, 0, PlayerType.x)
          .withMove(0, 1, PlayerType.x)
          .withMove(1, 0, PlayerType.o);
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsCpu,
      ).copyWith(board: board, currentTurn: PlayerType.o);

      final result = useCase(game);

      expect(result, isA<AiMoveFound>());
      final found = result as AiMoveFound;
      expect(found.row, 0);
      expect(found.col, 2);
      expect(found.reason, AiMoveReason.blockingMove);
    });

    test('should prioritize winning over blocking', () {
      final board = BoardEntity.empty(BoardSize.classic)
          .withMove(0, 0, PlayerType.o)
          .withMove(0, 1, PlayerType.o)
          .withMove(1, 0, PlayerType.x)
          .withMove(1, 1, PlayerType.x);
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsCpu,
      ).copyWith(board: board, currentTurn: PlayerType.o);

      final result = useCase(game);

      expect(result, isA<AiMoveFound>());
      final found = result as AiMoveFound;
      expect(found.row, 0);
      expect(found.col, 2);
      expect(found.reason, AiMoveReason.winningMove);
    });
  });

  group('AiMoveUseCase - Priority 3: Center', () {
    test('should take center on empty board', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsCpu,
      ).copyWith(currentTurn: PlayerType.o);

      final result = useCase(game);

      expect(result, isA<AiMoveFound>());
      final found = result as AiMoveFound;
      expect(found.row, 1);
      expect(found.col, 1);
      expect(found.reason, AiMoveReason.centerMove);
    });

    test('should take center when only corners taken', () {
      final board = BoardEntity.empty(BoardSize.classic)
          .withMove(0, 0, PlayerType.x);
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsCpu,
      ).copyWith(board: board, currentTurn: PlayerType.o);

      final result = useCase(game);

      expect(result, isA<AiMoveFound>());
      final found = result as AiMoveFound;
      expect(found.row, 1);
      expect(found.col, 1);
      expect(found.reason, AiMoveReason.centerMove);
    });
  });

  group('AiMoveUseCase - Priority 4: Corners', () {
    test('should take corner when center is taken', () {
      final board = BoardEntity.empty(BoardSize.classic)
          .withMove(1, 1, PlayerType.x);
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsCpu,
      ).copyWith(board: board, currentTurn: PlayerType.o);

      when(() => mockRandom.nextInt(any())).thenReturn(0);

      final result = useCase(game);

      expect(result, isA<AiMoveFound>());
      final found = result as AiMoveFound;
      final isCorner = (found.row == 0 || found.row == 2) &&
          (found.col == 0 || found.col == 2);
      expect(isCorner, true);
      expect(found.reason, AiMoveReason.cornerMove);
    });
  });

  group('AiMoveUseCase - Priority 5: Random', () {
    test('should take random position when no strategic move available', () {
      final board = BoardEntity.empty(BoardSize.classic)
          .withMove(0, 0, PlayerType.x)
          .withMove(0, 2, PlayerType.o)
          .withMove(1, 1, PlayerType.x)
          .withMove(2, 0, PlayerType.o)
          .withMove(2, 2, PlayerType.x);
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsCpu,
      ).copyWith(board: board, currentTurn: PlayerType.o);

      when(() => mockRandom.nextInt(any())).thenReturn(0);

      final result = useCase(game);

      expect(result, isA<AiMoveFound>());
      final found = result as AiMoveFound;
      expect(found.reason, AiMoveReason.randomMove);
    });
  });

  group('AiMoveUseCase - Error cases', () {
    test('should return not found when game is over', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsCpu,
      ).copyWith(status: GameStatus.xWins);

      final result = useCase(game);

      expect(result, isA<AiMoveNotFound>());
    });

    test('should return not found when not AI turn', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsCpu,
      ).copyWith(currentTurn: PlayerType.x);

      final result = useCase(game, aiPlayer: PlayerType.o);

      expect(result, isA<AiMoveNotFound>());
    });
  });

  group('AiMoveUseCase - 6x6 board', () {
    test('should work correctly on 6x6 board', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.extended,
        mode: GameMode.playerVsCpu,
      ).copyWith(currentTurn: PlayerType.o);

      when(() => mockRandom.nextInt(any())).thenReturn(0);

      final result = useCase(game);

      expect(result, isA<AiMoveFound>());
      final found = result as AiMoveFound;
      expect(found.reason, AiMoveReason.centerMove);
    });

    test('should require 4 in a row to win on 6x6', () {
      final board = BoardEntity.empty(BoardSize.extended)
          .withMove(0, 0, PlayerType.o)
          .withMove(0, 1, PlayerType.o)
          .withMove(0, 2, PlayerType.o);
      final game = GameEntity.newGame(
        boardSize: BoardSize.extended,
        mode: GameMode.playerVsCpu,
      ).copyWith(board: board, currentTurn: PlayerType.o);

      final result = useCase(game);

      expect(result, isA<AiMoveFound>());
      final found = result as AiMoveFound;
      expect(found.row, 0);
      expect(found.col, 3);
      expect(found.reason, AiMoveReason.winningMove);
    });
  });

  group('GameEntityAiExtension', () {
    test('getAiMove extension should work correctly', () {
      final game = GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsCpu,
      ).copyWith(currentTurn: PlayerType.o);

      final result = game.getAiMove();

      expect(result, isA<AiMoveFound>());
    });
  });
}
