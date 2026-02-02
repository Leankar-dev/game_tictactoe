import 'package:equatable/equatable.dart';
import '../../domain/entities/entities.dart';
import '../../domain/enums/enums.dart';

class GameState extends Equatable {
  final GameEntity game;
  final bool isLoading;
  final String? errorMessage;
  final bool showGameOverDialog;
  final bool isAiThinking;
  final ({int row, int col})? lastMovePosition;
  final bool hasUnsavedChanges;

  const GameState({
    required this.game,
    this.isLoading = false,
    this.errorMessage,
    this.showGameOverDialog = false,
    this.isAiThinking = false,
    this.lastMovePosition,
    this.hasUnsavedChanges = false,
  });

  factory GameState.initial({
    BoardSize boardSize = BoardSize.classic,
    GameMode gameMode = GameMode.playerVsPlayer,
  }) {
    return GameState(
      game: GameEntity.newGame(
        boardSize: boardSize,
        mode: gameMode,
      ),
    );
  }

  factory GameState.loading() {
    return GameState(
      game: GameEntity.newGame(
        boardSize: BoardSize.classic,
        mode: GameMode.playerVsPlayer,
      ),
      isLoading: true,
    );
  }

  BoardEntity get board => game.board;

  BoardSize get boardSize => game.boardSize;

  GameMode get gameMode => game.mode;

  GameStatus get status => game.status;

  PlayerType get currentTurn => game.currentTurn;

  bool get isGameOver => game.isGameOver;

  bool get hasWinner => game.hasWinner;

  int get moveCount => game.moveCount;

  List<MoveEntity> get moveHistory => game.moveHistory;

  List<({int row, int col})>? get winningCells => game.winningCells;

  bool get isCpuTurn => game.isCpuTurn;

  bool get canUndo => moveHistory.isNotEmpty && !isGameOver;

  PlayerType getCellPlayer(int row, int col) => board.getCell(row, col);

  bool isWinningCell(int row, int col) {
    if (winningCells == null) return false;
    return winningCells!.any((c) => c.row == row && c.col == col);
  }

  bool isLastMove(int row, int col) {
    if (lastMovePosition == null) return false;
    return lastMovePosition!.row == row && lastMovePosition!.col == col;
  }

  String get statusMessage {
    if (isLoading) return 'Loading...';
    if (isAiThinking) return 'CPU is thinking...';
    if (errorMessage != null) return errorMessage!;

    switch (status) {
      case GameStatus.playing:
        return currentTurn == PlayerType.x
            ? "${game.playerX.name}'s Turn"
            : "${game.playerO.name}'s Turn";
      case GameStatus.xWins:
        return '${game.playerX.name} Wins!';
      case GameStatus.oWins:
        return '${game.playerO.name} Wins!';
      case GameStatus.draw:
        return "It's a Draw!";
    }
  }

  GameState copyWith({
    GameEntity? game,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    bool? showGameOverDialog,
    bool? isAiThinking,
    ({int row, int col})? lastMovePosition,
    bool clearLastMove = false,
    bool? hasUnsavedChanges,
  }) {
    return GameState(
      game: game ?? this.game,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      showGameOverDialog: showGameOverDialog ?? this.showGameOverDialog,
      isAiThinking: isAiThinking ?? this.isAiThinking,
      lastMovePosition: clearLastMove ? null : (lastMovePosition ?? this.lastMovePosition),
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
    );
  }

  @override
  List<Object?> get props => [
        game,
        isLoading,
        errorMessage,
        showGameOverDialog,
        isAiThinking,
        lastMovePosition,
        hasUnsavedChanges,
      ];

  @override
  String toString() =>
      'GameState(status: $status, turn: ${currentTurn.symbol}, moves: $moveCount, loading: $isLoading)';
}
