import 'dart:math';
import '../entities/entities.dart';
import '../enums/enums.dart';
import '../../data/models/settings_model.dart';
import 'ai_move_usecase.dart';
import 'check_winner_usecase.dart';

class DifficultyAiUseCase {
  final CheckWinnerUseCase _checkWinnerUseCase;
  final Random _random;

  DifficultyAiUseCase({
    CheckWinnerUseCase? checkWinnerUseCase,
    Random? random,
  })  : _checkWinnerUseCase = checkWinnerUseCase ?? const CheckWinnerUseCase(),
        _random = random ?? Random();

  AiMoveResult call(
    GameEntity game, {
    required AiDifficulty difficulty,
    PlayerType? aiPlayer,
  }) {
    final player = aiPlayer ?? game.currentTurn;

    if (game.isGameOver) {
      return const AiMoveNotFound('Game is already over');
    }

    if (game.currentTurn != player) {
      return const AiMoveNotFound('Not AI player\'s turn');
    }

    switch (difficulty) {
      case AiDifficulty.easy:
        return _playEasy(game, player);
      case AiDifficulty.medium:
        return _playMedium(game, player);
      case AiDifficulty.hard:
        return _playHard(game, player);
    }
  }

  AiMoveResult _playEasy(GameEntity game, PlayerType player) {
    final emptyCells = game.board.emptyCells;
    if (emptyCells.isEmpty) {
      return const AiMoveNotFound('No available moves');
    }

    if (_random.nextDouble() < 0.3) {
      final winningMove = _findWinningMove(game.board, player);
      if (winningMove != null) {
        return AiMoveFound(
          position: winningMove,
          reason: AiMoveReason.winningMove,
        );
      }
    }

    final randomIndex = _random.nextInt(emptyCells.length);
    return AiMoveFound(
      position: emptyCells[randomIndex],
      reason: AiMoveReason.randomMove,
    );
  }

  AiMoveResult _playMedium(GameEntity game, PlayerType player) {
    final emptyCells = game.board.emptyCells;
    if (emptyCells.isEmpty) {
      return const AiMoveNotFound('No available moves');
    }

    final winningMove = _findWinningMove(game.board, player);
    if (winningMove != null) {
      return AiMoveFound(
        position: winningMove,
        reason: AiMoveReason.winningMove,
      );
    }

    if (_random.nextDouble() < 0.8) {
      final blockingMove = _findWinningMove(game.board, player.opponent);
      if (blockingMove != null) {
        return AiMoveFound(
          position: blockingMove,
          reason: AiMoveReason.blockingMove,
        );
      }
    }

    final centerMove = _findCenterMove(game.board);
    if (centerMove != null) {
      return AiMoveFound(
        position: centerMove,
        reason: AiMoveReason.centerMove,
      );
    }

    final cornerMove = _findCornerMove(game.board);
    if (cornerMove != null) {
      return AiMoveFound(
        position: cornerMove,
        reason: AiMoveReason.cornerMove,
      );
    }

    final randomIndex = _random.nextInt(emptyCells.length);
    return AiMoveFound(
      position: emptyCells[randomIndex],
      reason: AiMoveReason.randomMove,
    );
  }

  AiMoveResult _playHard(GameEntity game, PlayerType player) {
    final minimax = MinimaxAiUseCase(
      checkWinnerUseCase: _checkWinnerUseCase,
    );
    return minimax(game, aiPlayer: player);
  }

  ({int row, int col})? _findWinningMove(BoardEntity board, PlayerType player) {
    for (final cell in board.emptyCells) {
      final testBoard = board.withMove(cell.row, cell.col, player);
      final result = _checkWinnerUseCase.checkFromMove(
        testBoard,
        cell.row,
        cell.col,
      );
      if (result.winner == player) {
        return cell;
      }
    }
    return null;
  }

  ({int row, int col})? _findCenterMove(BoardEntity board) {
    final size = board.size.size;
    final center = size ~/ 2;

    if (size % 2 == 1 && board.isCellEmpty(center, center)) {
      return (row: center, col: center);
    }
    return null;
  }

  ({int row, int col})? _findCornerMove(BoardEntity board) {
    final size = board.size.size;
    final corners = [
      (row: 0, col: 0),
      (row: 0, col: size - 1),
      (row: size - 1, col: 0),
      (row: size - 1, col: size - 1),
    ];

    corners.shuffle(_random);
    for (final corner in corners) {
      if (board.isCellEmpty(corner.row, corner.col)) {
        return corner;
      }
    }
    return null;
  }
}
