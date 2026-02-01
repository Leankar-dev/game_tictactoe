enum BoardSize {
  classic(3, 3),
  extended(6, 4);

  final int size;
  final int winCondition;

  const BoardSize(this.size, this.winCondition);

  int get totalCells => size * size;

  String get displayName {
    switch (this) {
      case BoardSize.classic:
        return 'Classic (3x3)';
      case BoardSize.extended:
        return 'Extended (6x6)';
    }
  }

  static BoardSize fromString(String value) {
    switch (value.toLowerCase()) {
      case 'extended':
      case '6x6':
      case '6':
        return BoardSize.extended;
      case 'classic':
      case '3x3':
      case '3':
      default:
        return BoardSize.classic;
    }
  }
}
