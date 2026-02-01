import 'dart:math';
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
