import '../entities/entities.dart';
import '../enums/enums.dart';
import 'check_winner_usecase.dart';

sealed class MakeMoveResult {
  const MakeMoveResult();
}

class MakeMoveSuccess extends MakeMoveResult {
  final GameEntity game;
  final MoveEntity move;
  final WinnerCheckResult winnerCheck;

  const MakeMoveSuccess({
    required this.game,
    required this.move,
    required this.winnerCheck,
  });

  bool get gameEnded => winnerCheck.isGameOver;

  bool get isWinningMove => winnerCheck.hasWinner;
}

class MakeMoveFailure extends MakeMoveResult {
  final String message;
  final MakeMoveError error;

  const MakeMoveFailure({required this.message, required this.error});
}

enum MakeMoveError {
  gameOver('Game is already over'),
  cellOccupied('Cell is already occupied'),
  notYourTurn('It is not your turn'),
  outOfBounds('Position is out of bounds'),
  invalidPlayer('Invalid player');

  final String message;
  const MakeMoveError(this.message);
}

class MakeMoveUseCase {
  final CheckWinnerUseCase _checkWinnerUseCase;

  const MakeMoveUseCase({CheckWinnerUseCase? checkWinnerUseCase})
    : _checkWinnerUseCase = checkWinnerUseCase ?? const CheckWinnerUseCase();

  MakeMoveResult call(
    GameEntity game, {
    required int row,
    required int col,
    PlayerType? player,
  }) {
    final movingPlayer = player ?? game.currentTurn;

    final validationError = _validateMove(game, row, col, movingPlayer);
    if (validationError != null) {
      return MakeMoveFailure(
        message: validationError.message,
        error: validationError,
      );
    }

    final move = MoveEntity.create(
      row: row,
      col: col,
      player: movingPlayer,
      moveNumber: game.moveCount + 1,
    );

    final newBoard = game.board.withMove(row, col, movingPlayer);

    final winnerCheck = _checkWinnerUseCase.checkFromMove(newBoard, row, col);

    final newStatus = winnerCheck.toGameStatus();

    final nextTurn = newStatus.isPlaying
        ? movingPlayer.opponent
        : game.currentTurn;

    final updatedGame = game.copyWith(
      board: newBoard,
      currentTurn: nextTurn,
      status: newStatus,
      moveHistory: [...game.moveHistory, move],
      winningCells: winnerCheck.winningCells.isNotEmpty
          ? winnerCheck.winningCells
          : null,
    );

    return MakeMoveSuccess(
      game: updatedGame,
      move: move,
      winnerCheck: winnerCheck,
    );
  }

  MakeMoveError? _validateMove(
    GameEntity game,
    int row,
    int col,
    PlayerType player,
  ) {
    if (game.isGameOver) {
      return MakeMoveError.gameOver;
    }

    if (!player.isPlayer) {
      return MakeMoveError.invalidPlayer;
    }

    if (player != game.currentTurn) {
      return MakeMoveError.notYourTurn;
    }

    final size = game.board.size.size;
    if (row < 0 || row >= size || col < 0 || col >= size) {
      return MakeMoveError.outOfBounds;
    }

    if (!game.board.isCellEmpty(row, col)) {
      return MakeMoveError.cellOccupied;
    }

    return null;
  }

  bool isValidMove(GameEntity game, int row, int col, {PlayerType? player}) {
    final movingPlayer = player ?? game.currentTurn;
    return _validateMove(game, row, col, movingPlayer) == null;
  }

  List<({int row, int col})> getValidMoves(GameEntity game) {
    if (game.isGameOver) return [];
    return game.board.emptyCells;
  }
}

extension GameEntityMoveExtension on GameEntity {
  MakeMoveResult makeMove(
    int row,
    int col, {
    MakeMoveUseCase? useCase,
    PlayerType? player,
  }) {
    final makeMoveUseCase = useCase ?? const MakeMoveUseCase();
    return makeMoveUseCase(this, row: row, col: col, player: player);
  }
}
