import 'player_type.dart';

enum GameStatus {
  playing,
  xWins,
  oWins,
  draw;

  bool get isPlaying => this == GameStatus.playing;

  bool get isGameOver => this != GameStatus.playing;

  bool get hasWinner => this == GameStatus.xWins || this == GameStatus.oWins;

  PlayerType get winner {
    switch (this) {
      case GameStatus.xWins:
        return PlayerType.x;
      case GameStatus.oWins:
        return PlayerType.o;
      default:
        return PlayerType.none;
    }
  }

  static GameStatus fromWinner(PlayerType player) {
    switch (player) {
      case PlayerType.x:
        return GameStatus.xWins;
      case PlayerType.o:
        return GameStatus.oWins;
      case PlayerType.none:
        return GameStatus.playing;
    }
  }

  static GameStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'xwins':
      case 'x':
        return GameStatus.xWins;
      case 'owins':
      case 'o':
        return GameStatus.oWins;
      case 'draw':
        return GameStatus.draw;
      default:
        return GameStatus.playing;
    }
  }
}
