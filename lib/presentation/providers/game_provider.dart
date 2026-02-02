import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/providers.dart';
import '../../domain/entities/entities.dart';
import '../../domain/enums/enums.dart';
import '../../domain/usecases/make_move_usecase.dart';
import '../../domain/usecases/ai_move_usecase.dart';
import 'game_state.dart';

final gameProvider = NotifierProvider<GameNotifier, GameState>(GameNotifier.new);

class GameNotifier extends Notifier<GameState> {
  Timer? _aiDelayTimer;

  @override
  GameState build() {
    ref.onDispose(() {
      _cancelAiTimer();
    });

    return GameState.initial();
  }

  void startGame({
    required BoardSize boardSize,
    required GameMode gameMode,
    String? playerXName,
    String? playerOName,
  }) {
    _cancelAiTimer();

    final game = GameEntity.newGame(
      boardSize: boardSize,
      mode: gameMode,
      playerX: playerXName != null
          ? PlayerEntity.playerX(name: playerXName)
          : null,
      playerO: playerOName != null
          ? PlayerEntity.playerO(
              name: playerOName,
              isCpu: gameMode == GameMode.playerVsCpu,
            )
          : null,
    );

    state = GameState(
      game: game,
      hasUnsavedChanges: false,
    );
  }

  void makeMove(int row, int col) {
    if (state.isLoading || state.isAiThinking || state.isGameOver) {
      return;
    }

    if (state.isCpuTurn) {
      return;
    }

    _executeMove(row, col);
  }

  void _executeMove(int row, int col) {
    final makeMoveUseCase = ref.read(makeMoveUseCaseProvider);
    final result = makeMoveUseCase(state.game, row: row, col: col);

    switch (result) {
      case MakeMoveSuccess success:
        state = state.copyWith(
          game: success.game,
          lastMovePosition: (row: row, col: col),
          hasUnsavedChanges: true,
          clearError: true,
        );

        if (success.gameEnded) {
          _onGameOver();
        } else if (state.isCpuTurn) {
          _scheduleCpuMove();
        }

      case MakeMoveFailure failure:
        state = state.copyWith(
          errorMessage: failure.message,
        );
    }
  }

  void _scheduleCpuMove() {
    state = state.copyWith(isAiThinking: true);

    _aiDelayTimer = Timer(const Duration(milliseconds: 500), () {
      _executeCpuMove();
    });
  }

  void _executeCpuMove() {
    final aiMoveUseCase = ref.read(aiMoveUseCaseProvider);
    final aiResult = aiMoveUseCase(state.game);

    switch (aiResult) {
      case AiMoveFound found:
        state = state.copyWith(isAiThinking: false);
        _executeMove(found.row, found.col);

      case AiMoveNotFound notFound:
        state = state.copyWith(
          isAiThinking: false,
          errorMessage: notFound.message,
        );
    }
  }

  void _onGameOver() {
    state = state.copyWith(
      showGameOverDialog: true,
    );
  }

  void dismissGameOverDialog() {
    state = state.copyWith(showGameOverDialog: false);
  }

  void restartGame() {
    _cancelAiTimer();

    startGame(
      boardSize: state.boardSize,
      gameMode: state.gameMode,
      playerXName: state.game.playerX.name,
      playerOName: state.game.playerO.name,
    );
  }

  void undoMove() {
    if (!state.canUndo || state.isAiThinking) return;

    _cancelAiTimer();

    final currentGame = state.game;
    final moves = List<MoveEntity>.from(currentGame.moveHistory);

    int movesToUndo = currentGame.mode == GameMode.playerVsCpu ? 2 : 1;
    movesToUndo = movesToUndo.clamp(1, moves.length);

    for (int i = 0; i < movesToUndo; i++) {
      if (moves.isNotEmpty) moves.removeLast();
    }

    var board = BoardEntity.empty(currentGame.boardSize);
    for (final move in moves) {
      board = board.withMove(move.row, move.col, move.player);
    }

    final nextTurn = moves.length.isEven ? PlayerType.x : PlayerType.o;

    final updatedGame = currentGame.copyWith(
      board: board,
      moveHistory: moves,
      currentTurn: nextTurn,
      status: GameStatus.playing,
      winningCells: null,
    );

    state = state.copyWith(
      game: updatedGame,
      showGameOverDialog: false,
      clearLastMove: true,
      hasUnsavedChanges: true,
    );
  }

  Future<void> saveGame() async {
    if (!state.isGameOver) return;

    try {
      state = state.copyWith(isLoading: true);
      final gameRepository = ref.read(gameRepositoryProvider);
      await gameRepository.saveGame(state.game);
      state = state.copyWith(
        isLoading: false,
        hasUnsavedChanges: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to save game: $e',
      );
    }
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  void _cancelAiTimer() {
    _aiDelayTimer?.cancel();
    _aiDelayTimer = null;
  }
}

final boardProvider = Provider<BoardEntity>((ref) {
  return ref.watch(gameProvider.select((state) => state.board));
});

final gameStatusProvider = Provider<GameStatus>((ref) {
  return ref.watch(gameProvider.select((state) => state.status));
});

final currentTurnProvider = Provider<PlayerType>((ref) {
  return ref.watch(gameProvider.select((state) => state.currentTurn));
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(gameProvider.select((state) => state.isLoading || state.isAiThinking));
});
