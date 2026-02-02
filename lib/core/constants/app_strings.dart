abstract class AppStrings {
  static const String appName = 'Tic Tac Toe';
  static const String appVersion = '0.7.1+1';

  // Navigation
  static const String home = 'Home';
  static const String game = 'Game';
  static const String statistics = 'Statistics';
  static const String settings = 'Settings';

  // Game modes
  static const String classicMode = 'Classic (3x3)';
  static const String extendedMode = 'Extended (6x6)';
  static const String playerVsPlayer = 'Player vs Player';
  static const String playerVsCpu = 'Player vs CPU';

  // Game status messages
  static const String playerXTurn = "Player X's Turn";
  static const String playerOTurn = "Player O's Turn";
  static const String playerXWins = 'Player X Wins!';
  static const String playerOWins = 'Player O Wins!';
  static const String draw = "It's a Draw!";
  static const String loading = 'Loading...';
  static const String cpuThinking = 'CPU is thinking...';

  // Dynamic game messages (use with string interpolation)
  static String playerTurn(String playerName) => "$playerName's Turn";
  static String playerWins(String playerName) => '$playerName Wins!';

  // Game actions
  static const String newGame = 'New Game';
  static const String restart = 'Restart';
  static const String undo = 'Undo';
  static const String mainMenu = 'Main Menu';
  static const String play = 'Play';
  static const String start = 'Start';

  // Statistics
  static const String totalGames = 'Total Games';
  static const String wins = 'Wins';
  static const String losses = 'Losses';
  static const String draws = 'Draws';
  static const String winRate = 'Win Rate';

  // Statistics filters
  static const String allGames = 'All Games';
  static const String classicPvp = 'Classic - Player vs Player';
  static const String classicPvc = 'Classic - Player vs CPU';
  static const String extendedPvp = 'Extended - Player vs Player';
  static const String extendedPvc = 'Extended - Player vs CPU';

  // Settings
  static const String soundEffects = 'Sound Effects';
  static const String hapticFeedback = 'Haptic Feedback';
  static const String difficulty = 'Difficulty';
  static const String easy = 'Easy';
  static const String medium = 'Medium';
  static const String hard = 'Hard';

  // Dialogs
  static const String selectMode = 'Select Game Mode';
  static const String selectBoardSize = 'Select Board Size';
  static const String confirmRestart = 'Are you sure you want to restart?';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String cancel = 'Cancel';

  // Placeholder screen
  static const String underConstruction = 'EM CONSTRUÇÃO';
  static const String underConstructionMessage =
      'APP EM CONSTRUÇÃO\nVolte mais tarde para jogar!';

  // Error messages
  static const String failedToSaveGame = 'Failed to save game';
  static const String failedToLoadSettings = 'Failed to load settings';
  static const String failedToResetSettings = 'Failed to reset settings';
  static const String failedToUpdateSetting = 'Failed to update setting';
  static const String failedToLoadStatistics = 'Failed to load statistics';
  static const String failedToResetStatistics = 'Failed to reset statistics';

  // Error message helper (appends exception details)
  static String errorWithDetails(String message, Object error) =>
      '$message: $error';
}
