import '../entities/board_entity.dart';
import '../enums/enums.dart';

class WinnerCheckResult {
  final PlayerType winner;
  final List<({int row, int col})> winningCells;
  final bool isDraw;

  const WinnerCheckResult({
    required this.winner,
    required this.winningCells,
    required this.isDraw,
  });

  factory WinnerCheckResult.noWinner() => const WinnerCheckResult(
    winner: PlayerType.none,
    winningCells: [],
    isDraw: false,
  );

  factory WinnerCheckResult.draw() => const WinnerCheckResult(
    winner: PlayerType.none,
    winningCells: [],
    isDraw: true,
  );

  factory WinnerCheckResult.winner(
    PlayerType player,
    List<({int row, int col})> cells,
  ) => WinnerCheckResult(winner: player, winningCells: cells, isDraw: false);

  bool get hasWinner => winner != PlayerType.none;

  bool get isGameOver => hasWinner || isDraw;

  GameStatus toGameStatus() {
    if (hasWinner) {
      return GameStatus.fromWinner(winner);
    }
    if (isDraw) {
      return GameStatus.draw;
    }
    return GameStatus.playing;
  }
}

class CheckWinnerUseCase {
  const CheckWinnerUseCase();

  WinnerCheckResult call(BoardEntity board) {
    final size = board.size.size;
    final winCondition = board.size.winCondition;

    for (int row = 0; row < size; row++) {
      final result = _checkLine(
        board,
        List.generate(size, (col) => (row: row, col: col)),
        winCondition,
      );
      if (result.hasWinner) return result;
    }

    for (int col = 0; col < size; col++) {
      final result = _checkLine(
        board,
        List.generate(size, (row) => (row: row, col: col)),
        winCondition,
      );
      if (result.hasWinner) return result;
    }

    final diagonalResult = _checkDiagonals(board, winCondition);
    if (diagonalResult.hasWinner) return diagonalResult;

    if (board.isFull) {
      return WinnerCheckResult.draw();
    }

    return WinnerCheckResult.noWinner();
  }

  WinnerCheckResult checkFromMove(BoardEntity board, int lastRow, int lastCol) {
    final winCondition = board.size.winCondition;
    final player = board.getCell(lastRow, lastCol);

    if (player == PlayerType.none) {
      return WinnerCheckResult.noWinner();
    }

    final horizontalResult = _checkLineFromPosition(
      board,
      lastRow,
      lastCol,
      0,
      1,
      winCondition,
    );
    if (horizontalResult.hasWinner) return horizontalResult;

    final verticalResult = _checkLineFromPosition(
      board,
      lastRow,
      lastCol,
      1,
      0,
      winCondition,
    );
    if (verticalResult.hasWinner) return verticalResult;

    final mainDiagonalResult = _checkLineFromPosition(
      board,
      lastRow,
      lastCol,
      1,
      1,
      winCondition,
    );
    if (mainDiagonalResult.hasWinner) return mainDiagonalResult;

    final antiDiagonalResult = _checkLineFromPosition(
      board,
      lastRow,
      lastCol,
      1,
      -1,
      winCondition,
    );
    if (antiDiagonalResult.hasWinner) return antiDiagonalResult;

    if (board.isFull) {
      return WinnerCheckResult.draw();
    }

    return WinnerCheckResult.noWinner();
  }

  WinnerCheckResult _checkLine(
    BoardEntity board,
    List<({int row, int col})> cells,
    int winCondition,
  ) {
    int consecutiveCount = 0;
    PlayerType lastPlayer = PlayerType.none;
    List<({int row, int col})> consecutiveCells = [];

    for (final cell in cells) {
      final current = board.getCell(cell.row, cell.col);

      if (current == PlayerType.none) {
        consecutiveCount = 0;
        lastPlayer = PlayerType.none;
        consecutiveCells.clear();
      } else if (current == lastPlayer) {
        consecutiveCount++;
        consecutiveCells.add(cell);

        if (consecutiveCount >= winCondition) {
          return WinnerCheckResult.winner(current, List.from(consecutiveCells));
        }
      } else {
        consecutiveCount = 1;
        lastPlayer = current;
        consecutiveCells = [cell];
      }
    }

    return WinnerCheckResult.noWinner();
  }

  WinnerCheckResult _checkDiagonals(BoardEntity board, int winCondition) {
    final size = board.size.size;

    for (int startCol = 0; startCol <= size - winCondition; startCol++) {
      final cells = <({int row, int col})>[];
      for (int i = 0; i < size - startCol; i++) {
        cells.add((row: i, col: startCol + i));
      }
      final result = _checkLine(board, cells, winCondition);
      if (result.hasWinner) return result;
    }

    for (int startRow = 1; startRow <= size - winCondition; startRow++) {
      final cells = <({int row, int col})>[];
      for (int i = 0; i < size - startRow; i++) {
        cells.add((row: startRow + i, col: i));
      }
      final result = _checkLine(board, cells, winCondition);
      if (result.hasWinner) return result;
    }

    for (int startCol = winCondition - 1; startCol < size; startCol++) {
      final cells = <({int row, int col})>[];
      for (int i = 0; i <= startCol; i++) {
        if (i < size) {
          cells.add((row: i, col: startCol - i));
        }
      }
      final result = _checkLine(board, cells, winCondition);
      if (result.hasWinner) return result;
    }

    for (int startRow = 1; startRow <= size - winCondition; startRow++) {
      final cells = <({int row, int col})>[];
      for (int i = 0; i < size - startRow; i++) {
        cells.add((row: startRow + i, col: size - 1 - i));
      }
      final result = _checkLine(board, cells, winCondition);
      if (result.hasWinner) return result;
    }

    return WinnerCheckResult.noWinner();
  }

  WinnerCheckResult _checkLineFromPosition(
    BoardEntity board,
    int row,
    int col,
    int deltaRow,
    int deltaCol,
    int winCondition,
  ) {
    final size = board.size.size;
    final player = board.getCell(row, col);

    if (player == PlayerType.none) {
      return WinnerCheckResult.noWinner();
    }

    final cells = <({int row, int col})>[(row: row, col: col)];

    int r = row + deltaRow;
    int c = col + deltaCol;
    while (r >= 0 && r < size && c >= 0 && c < size) {
      if (board.getCell(r, c) == player) {
        cells.add((row: r, col: c));
        r += deltaRow;
        c += deltaCol;
      } else {
        break;
      }
    }

    r = row - deltaRow;
    c = col - deltaCol;
    while (r >= 0 && r < size && c >= 0 && c < size) {
      if (board.getCell(r, c) == player) {
        cells.insert(0, (row: r, col: c));
        r -= deltaRow;
        c -= deltaCol;
      } else {
        break;
      }
    }

    if (cells.length >= winCondition) {
      return WinnerCheckResult.winner(player, cells.sublist(0, winCondition));
    }

    return WinnerCheckResult.noWinner();
  }
}
