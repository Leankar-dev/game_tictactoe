enum GameMode {
  playerVsPlayer('pvp', 'Player vs Player'),
  playerVsCpu('pvc', 'Player vs CPU');

  final String code;
  final String displayName;

  const GameMode(this.code, this.displayName);

  bool get hasCpu => this == GameMode.playerVsCpu;

  bool get isMultiplayer => this == GameMode.playerVsPlayer;

  static GameMode fromString(String value) {
    switch (value.toLowerCase()) {
      case 'pvc':
      case 'playervscpu':
      case 'cpu':
        return GameMode.playerVsCpu;
      case 'pvp':
      case 'playervsplayer':
      default:
        return GameMode.playerVsPlayer;
    }
  }
}
