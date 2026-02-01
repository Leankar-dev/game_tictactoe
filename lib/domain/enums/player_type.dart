enum PlayerType {
  x('X'),
  o('O'),
  none('');

  final String symbol;

  const PlayerType(this.symbol);

  bool get isPlayer => this != PlayerType.none;

  PlayerType get opponent {
    switch (this) {
      case PlayerType.x:
        return PlayerType.o;
      case PlayerType.o:
        return PlayerType.x;
      case PlayerType.none:
        return PlayerType.none;
    }
  }

  static PlayerType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'X':
        return PlayerType.x;
      case 'O':
        return PlayerType.o;
      default:
        return PlayerType.none;
    }
  }
}
