import 'package:equatable/equatable.dart';
import '../enums/enums.dart';

class BoardEntity extends Equatable {
  final List<List<PlayerType>> cells;
  final BoardSize size;

  const BoardEntity._({required this.cells, required this.size});

  factory BoardEntity.empty(BoardSize size) {
    final cells = List.generate(
      size.size,
      (_) => List.filled(size.size, PlayerType.none),
    );
    return BoardEntity._(cells: cells, size: size);
  }

  factory BoardEntity.fromCells(List<List<PlayerType>> cells, BoardSize size) {
    final copiedCells = cells.map((row) => List<PlayerType>.from(row)).toList();
    return BoardEntity._(cells: copiedCells, size: size);
  }

  PlayerType getCell(int row, int col) {
    if (row < 0 || row >= size.size || col < 0 || col >= size.size) {
      throw RangeError(
        'Position ($row, $col) is out of bounds for size ${size.size}',
      );
    }
    return cells[row][col];
  }

  bool isCellEmpty(int row, int col) => getCell(row, col) == PlayerType.none;

  bool get isFull {
    for (final row in cells) {
      for (final cell in row) {
        if (cell == PlayerType.none) return false;
      }
    }
    return true;
  }

  int get emptyCellCount {
    int count = 0;
    for (final row in cells) {
      for (final cell in row) {
        if (cell == PlayerType.none) count++;
      }
    }
    return count;
  }

  int get moveCount => size.totalCells - emptyCellCount;

  List<({int row, int col})> get emptyCells {
    final empty = <({int row, int col})>[];
    for (int row = 0; row < size.size; row++) {
      for (int col = 0; col < size.size; col++) {
        if (cells[row][col] == PlayerType.none) {
          empty.add((row: row, col: col));
        }
      }
    }
    return empty;
  }

  BoardEntity withMove(int row, int col, PlayerType player) {
    final newCells = cells.map((r) => List<PlayerType>.from(r)).toList();
    newCells[row][col] = player;
    return BoardEntity._(cells: newCells, size: size);
  }

  @override
  List<Object?> get props => [cells, size];

  @override
  String toString() {
    final buffer = StringBuffer('BoardEntity(${size.displayName}):\n');
    for (final row in cells) {
      buffer.writeln(
        row.map((c) => c == PlayerType.none ? '-' : c.symbol).join(' '),
      );
    }
    return buffer.toString();
  }
}
