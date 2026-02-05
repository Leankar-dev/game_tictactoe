import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:game_tictactoe/data/repositories/game_repository.dart';
import 'package:game_tictactoe/domain/entities/entities.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';
import 'package:game_tictactoe/presentation/providers/game_provider.dart';
import 'package:game_tictactoe/core/di/providers.dart';
import 'package:game_tictactoe/core/utils/feedback_service.dart';

class MockGameRepository extends Mock implements GameRepository {}

class MockFeedbackService extends Mock implements FeedbackService {}

void main() {
  late MockGameRepository mockRepository;
  late MockFeedbackService mockFeedbackService;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(
      GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      ),
    );
  });

  setUp(() {
    mockRepository = MockGameRepository();
    mockFeedbackService = MockFeedbackService();
    when(() => mockFeedbackService.onMove()).thenAnswer((_) async {});
    when(() => mockFeedbackService.onWin()).thenAnswer((_) async {});
    when(() => mockFeedbackService.onDraw()).thenAnswer((_) async {});
    when(() => mockFeedbackService.errorFeedback()).thenAnswer((_) async {});
    container = ProviderContainer(
      overrides: [
        gameRepositoryProvider.overrideWithValue(mockRepository),
        feedbackServiceProvider.overrideWithValue(mockFeedbackService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('GameNotifier', () {
    group('startGame', () {
      test('should start a new game with correct settings', () {
        final notifier = container.read(gameProvider.notifier);

        notifier.startGame(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        final state = container.read(gameProvider);
        expect(state.boardSize, BoardSize.classic);
        expect(state.gameMode, GameMode.playerVsPlayer);
        expect(state.status, GameStatus.playing);
        expect(state.currentTurn, PlayerType.x);
        expect(state.moveCount, 0);
      });

      test('should start extended game correctly', () {
        final notifier = container.read(gameProvider.notifier);

        notifier.startGame(
          boardSize: BoardSize.extended,
          gameMode: GameMode.playerVsCpu,
        );

        final state = container.read(gameProvider);
        expect(state.boardSize, BoardSize.extended);
        expect(state.gameMode, GameMode.playerVsCpu);
        expect(state.game.playerO.isCpu, true);
      });
    });

    group('makeMove', () {
      test('should make a valid move', () {
        final notifier = container.read(gameProvider.notifier);
        notifier.startGame(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        notifier.makeMove(0, 0);

        final state = container.read(gameProvider);
        expect(state.getCellPlayer(0, 0), PlayerType.x);
        expect(state.currentTurn, PlayerType.o);
        expect(state.moveCount, 1);
        expect(state.lastMovePosition, (row: 0, col: 0));
      });

      test('should alternate turns correctly', () {
        final notifier = container.read(gameProvider.notifier);
        notifier.startGame(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        notifier.makeMove(0, 0);
        expect(container.read(gameProvider).currentTurn, PlayerType.o);

        notifier.makeMove(0, 1);
        expect(container.read(gameProvider).currentTurn, PlayerType.x);

        notifier.makeMove(0, 2);
        expect(container.read(gameProvider).currentTurn, PlayerType.o);
      });

      test('should not allow move on occupied cell', () {
        final notifier = container.read(gameProvider.notifier);
        notifier.startGame(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        notifier.makeMove(0, 0);
        final countAfterFirst = container.read(gameProvider).moveCount;

        notifier.makeMove(0, 0);
        final countAfterSecond = container.read(gameProvider).moveCount;

        expect(countAfterSecond, countAfterFirst);
      });

      test('should detect winning move', () {
        final notifier = container.read(gameProvider.notifier);
        notifier.startGame(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        notifier.makeMove(0, 0);
        notifier.makeMove(1, 0);
        notifier.makeMove(0, 1);
        notifier.makeMove(1, 1);
        notifier.makeMove(0, 2);

        final state = container.read(gameProvider);
        expect(state.status, GameStatus.xWins);
        expect(state.isGameOver, true);
        expect(state.winningCells?.length, 3);
      });
    });

    group('undoMove', () {
      test('should undo last move in PvP', () {
        final notifier = container.read(gameProvider.notifier);
        notifier.startGame(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        notifier.makeMove(0, 0);
        notifier.makeMove(1, 1);
        expect(container.read(gameProvider).moveCount, 2);

        notifier.undoMove();

        final state = container.read(gameProvider);
        expect(state.moveCount, 1);
        expect(state.getCellPlayer(1, 1), PlayerType.none);
        expect(state.currentTurn, PlayerType.o);
      });

      test('should not undo when no moves', () {
        final notifier = container.read(gameProvider.notifier);
        notifier.startGame(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        notifier.undoMove();

        expect(container.read(gameProvider).moveCount, 0);
      });

      test('should not undo when game is over', () {
        final notifier = container.read(gameProvider.notifier);
        notifier.startGame(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        notifier.makeMove(0, 0);
        notifier.makeMove(1, 0);
        notifier.makeMove(0, 1);
        notifier.makeMove(1, 1);
        notifier.makeMove(0, 2);

        expect(container.read(gameProvider).isGameOver, true);
        final moveCount = container.read(gameProvider).moveCount;

        notifier.undoMove();

        expect(container.read(gameProvider).moveCount, moveCount);
      });
    });

    group('restartGame', () {
      test('should restart with same settings', () {
        final notifier = container.read(gameProvider.notifier);
        notifier.startGame(
          boardSize: BoardSize.extended,
          gameMode: GameMode.playerVsPlayer,
        );

        notifier.makeMove(0, 0);
        notifier.makeMove(1, 1);

        notifier.restartGame();

        final state = container.read(gameProvider);
        expect(state.boardSize, BoardSize.extended);
        expect(state.gameMode, GameMode.playerVsPlayer);
        expect(state.moveCount, 0);
        expect(state.status, GameStatus.playing);
      });
    });

    group('saveGame', () {
      test('should save completed game', () async {
        when(() => mockRepository.saveGame(any())).thenAnswer((_) async {});

        final notifier = container.read(gameProvider.notifier);
        notifier.startGame(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        notifier.makeMove(0, 0);
        notifier.makeMove(1, 0);
        notifier.makeMove(0, 1);
        notifier.makeMove(1, 1);
        notifier.makeMove(0, 2);

        await notifier.saveGame();

        verify(() => mockRepository.saveGame(any())).called(1);
      });

      test('should not save incomplete game', () async {
        final notifier = container.read(gameProvider.notifier);
        notifier.startGame(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        notifier.makeMove(0, 0);

        await notifier.saveGame();

        verifyNever(() => mockRepository.saveGame(any()));
      });
    });
  });

  group('Selector providers', () {
    test('boardProvider should return current board', () {
      final notifier = container.read(gameProvider.notifier);
      notifier.startGame(
        boardSize: BoardSize.classic,
        gameMode: GameMode.playerVsPlayer,
      );

      notifier.makeMove(0, 0);

      final board = container.read(boardProvider);
      expect(board.getCell(0, 0), PlayerType.x);
    });

    test('gameStatusProvider should return current status', () {
      final notifier = container.read(gameProvider.notifier);
      notifier.startGame(
        boardSize: BoardSize.classic,
        gameMode: GameMode.playerVsPlayer,
      );

      expect(container.read(gameStatusProvider), GameStatus.playing);
    });

    test('currentTurnProvider should track turns', () {
      final notifier = container.read(gameProvider.notifier);
      notifier.startGame(
        boardSize: BoardSize.classic,
        gameMode: GameMode.playerVsPlayer,
      );

      expect(container.read(currentTurnProvider), PlayerType.x);

      notifier.makeMove(0, 0);
      expect(container.read(currentTurnProvider), PlayerType.o);
    });
  });
}
