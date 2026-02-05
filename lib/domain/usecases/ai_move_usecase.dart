import 'dart:math';
import '../../data/models/settings_model.dart';
import '../entities/entities.dart';
import '../enums/enums.dart';
import 'check_winner_usecase.dart';

sealed class AiMoveResult {
  const AiMoveResult();
}

class AiMoveFound extends AiMoveResult {
  final ({int row, int col}) position;
  final AiMoveReason reason;

  const AiMoveFound({
    required this.position,
    required this.reason,
  });

  int get row => position.row;
  int get col => position.col;
}

class AiMoveNotFound extends AiMoveResult {
  final String message;

  const AiMoveNotFound(this.message);
}

enum AiMoveReason {
  winningMove('Winning move'),
  blockingMove('Blocking opponent'),
  centerMove('Taking center'),
  cornerMove('Taking corner'),
  randomMove('Available position');

  final String description;
  const AiMoveReason(this.description);
}

class AiMoveUseCase {
  final CheckWinnerUseCase _checkWinnerUseCase;
  final Random _random;

  AiMoveUseCase({
    CheckWinnerUseCase? checkWinnerUseCase,
    Random? random,
  })  : _checkWinnerUseCase = checkWinnerUseCase ?? const CheckWinnerUseCase(),
        _random = random ?? Random();

  AiMoveResult call(GameEntity game, {PlayerType? aiPlayer}) {
    final player = aiPlayer ?? game.currentTurn;

    if (game.isGameOver) {
      return const AiMoveNotFound('Game is already over');
    }

    if (game.currentTurn != player) {
      return const AiMoveNotFound('Not AI player\'s turn');
    }

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

    final blockingMove = _findWinningMove(game.board, player.opponent);
    if (blockingMove != null) {
      return AiMoveFound(
        position: blockingMove,
        reason: AiMoveReason.blockingMove,
      );
    }

    final centerMove = _findCenterMove(game.board);
    if (centerMove != null) {
      return AiMoveFound(
        position: centerMove,
        reason: AiMoveReason.centerMove,
      );
    }

    final cornerMove = _findCornerMove(game.board, emptyCells);
    if (cornerMove != null) {
      return AiMoveFound(
        position: cornerMove,
        reason: AiMoveReason.cornerMove,
      );
    }

    final randomMove = emptyCells[_random.nextInt(emptyCells.length)];
    return AiMoveFound(
      position: randomMove,
      reason: AiMoveReason.randomMove,
    );
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

    if (size % 2 == 1) {
      if (board.isCellEmpty(center, center)) {
        return (row: center, col: center);
      }
    } else {
      final centers = [
        (row: center - 1, col: center - 1),
        (row: center - 1, col: center),
        (row: center, col: center - 1),
        (row: center, col: center),
      ];

      centers.shuffle(_random);
      for (final pos in centers) {
        if (board.isCellEmpty(pos.row, pos.col)) {
          return pos;
        }
      }
    }

    return null;
  }

  ({int row, int col})? _findCornerMove(
    BoardEntity board,
    List<({int row, int col})> emptyCells,
  ) {
    final size = board.size.size;
    final lastIndex = size - 1;

    final corners = [
      (row: 0, col: 0),
      (row: 0, col: lastIndex),
      (row: lastIndex, col: 0),
      (row: lastIndex, col: lastIndex),
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

extension GameEntityAiExtension on GameEntity {
  AiMoveResult getAiMove({AiMoveUseCase? useCase, PlayerType? aiPlayer}) {
    final aiMoveUseCase = useCase ?? AiMoveUseCase();
    return aiMoveUseCase(this, aiPlayer: aiPlayer);
  }
}

/// Advanced AI using Minimax algorithm with Alpha-Beta pruning.
class MinimaxAiUseCase {
  final CheckWinnerUseCase _checkWinnerUseCase;

  const MinimaxAiUseCase({
    CheckWinnerUseCase? checkWinnerUseCase,
  }) : _checkWinnerUseCase = checkWinnerUseCase ?? const CheckWinnerUseCase();

  /// Calculates the best move using Minimax.
  ///
  /// [game] - Current game state
  /// [aiPlayer] - The player type the AI is playing as
  /// [maxDepth] - Maximum search depth (lower = faster but weaker)
  AiMoveResult call(
    GameEntity game, {
    PlayerType? aiPlayer,
    int maxDepth = 9,
  }) {
    final player = aiPlayer ?? game.currentTurn;

    if (game.isGameOver) {
      return const AiMoveNotFound('Game is already over');
    }

    if (game.currentTurn != player) {
      return const AiMoveNotFound('Not AI player\'s turn');
    }

    final emptyCells = game.board.emptyCells;
    if (emptyCells.isEmpty) {
      return const AiMoveNotFound('No available moves');
    }

    // For first move on empty 3x3 board, just pick a corner (optimization)
    if (game.boardSize == BoardSize.classic && game.moveCount == 0) {
      return const AiMoveFound(
        position: (row: 0, col: 0),
        reason: AiMoveReason.cornerMove,
      );
    }

    // Find best move using Minimax
    var bestScore = double.negativeInfinity;
    ({int row, int col})? bestMove;

    for (final cell in emptyCells) {
      // Simulate move
      final newBoard = game.board.withMove(cell.row, cell.col, player);

      // Calculate score
      final score = _minimax(
        board: newBoard,
        depth: maxDepth - 1,
        alpha: double.negativeInfinity,
        beta: double.infinity,
        isMaximizing: false,
        aiPlayer: player,
        lastMove: cell,
      );

      if (score > bestScore) {
        bestScore = score;
        bestMove = cell;
      }
    }

    if (bestMove == null) {
      return const AiMoveNotFound('No valid move found');
    }

    return AiMoveFound(
      position: bestMove,
      reason: AiMoveReason.winningMove, // Minimax always plays optimally
    );
  }

  /// Minimax algorithm with alpha-beta pruning.
  double _minimax({
    required BoardEntity board,
    required int depth,
    required double alpha,
    required double beta,
    required bool isMaximizing,
    required PlayerType aiPlayer,
    required ({int row, int col}) lastMove,
  }) {
    // Check terminal state
    final winnerCheck = _checkWinnerUseCase.checkFromMove(
      board,
      lastMove.row,
      lastMove.col,
    );

    if (winnerCheck.hasWinner) {
      // AI won
      if (winnerCheck.winner == aiPlayer) {
        return 10.0 + depth; // Prefer faster wins
      }
      // Opponent won
      return -10.0 - depth; // Prefer slower losses
    }

    if (winnerCheck.isDraw || depth == 0) {
      return 0.0; // Draw or depth limit
    }

    final emptyCells = board.emptyCells;
    if (emptyCells.isEmpty) {
      return 0.0;
    }

    final currentPlayer = isMaximizing ? aiPlayer : aiPlayer.opponent;
    var mutableAlpha = alpha;
    var mutableBeta = beta;

    if (isMaximizing) {
      var maxEval = double.negativeInfinity;

      for (final cell in emptyCells) {
        final newBoard = board.withMove(cell.row, cell.col, currentPlayer);
        final eval = _minimax(
          board: newBoard,
          depth: depth - 1,
          alpha: mutableAlpha,
          beta: mutableBeta,
          isMaximizing: false,
          aiPlayer: aiPlayer,
          lastMove: cell,
        );

        maxEval = max(maxEval, eval);
        mutableAlpha = max(mutableAlpha, eval);

        // Alpha-beta pruning
        if (mutableBeta <= mutableAlpha) {
          break;
        }
      }

      return maxEval;
    } else {
      var minEval = double.infinity;

      for (final cell in emptyCells) {
        final newBoard = board.withMove(cell.row, cell.col, currentPlayer);
        final eval = _minimax(
          board: newBoard,
          depth: depth - 1,
          alpha: mutableAlpha,
          beta: mutableBeta,
          isMaximizing: true,
          aiPlayer: aiPlayer,
          lastMove: cell,
        );

        minEval = min(minEval, eval);
        mutableBeta = min(mutableBeta, eval);

        // Alpha-beta pruning
        if (mutableBeta <= mutableAlpha) {
          break;
        }
      }

      return minEval;
    }
  }
}

/// Factory that creates the appropriate AI based on difficulty.
class AiFactory {
  static AiMoveUseCase create(AiDifficulty difficulty) {
    switch (difficulty) {
      case AiDifficulty.easy:
        // Random moves with occasional good plays
        return AiMoveUseCase();
      case AiDifficulty.medium:
        // Priority-based (existing implementation)
        return AiMoveUseCase();
      case AiDifficulty.hard:
        // Minimax - unbeatable
        // Note: We need an adapter since MinimaxAiUseCase has different interface
        return _MinimaxAdapter();
    }
  }
}

class _MinimaxAdapter extends AiMoveUseCase {
  final MinimaxAiUseCase _minimax = const MinimaxAiUseCase();

  @override
  AiMoveResult call(GameEntity game, {PlayerType? aiPlayer}) {
    return _minimax(game, aiPlayer: aiPlayer);
  }
}
