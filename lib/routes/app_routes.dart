abstract class AppRoutes {
  static const String home = '/';
  static const String game = '/game';
  static const String statistics = '/statistics';
  static const String settings = '/settings';

  static const String homeName = 'home';
  static const String gameName = 'game';
  static const String statisticsName = 'statistics';
  static const String settingsName = 'settings';

  static const String boardSizeParam = 'boardSize';
  static const String gameModeParam = 'gameMode';

  static String gameWithParams({
    required String boardSize,
    required String gameMode,
  }) {
    return '$game?$boardSizeParam=$boardSize&$gameModeParam=$gameMode';
  }
}

enum RouteTransition { material, fade, slideRight, slideBottom, scale }
