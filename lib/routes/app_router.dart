import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/enums/enums.dart';
import '../presentation/screens/game/game_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/settings/settings_screen.dart';
import '../presentation/screens/statistics/statistics_screen.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.game,
        name: AppRoutes.gameName,
        builder: (context, state) {
          final boardSizeStr =
              state.uri.queryParameters[AppRoutes.boardSizeParam] ?? 'classic';
          final gameModeStr =
              state.uri.queryParameters[AppRoutes.gameModeParam] ?? 'pvp';

          return GameScreen(
            boardSize: BoardSize.fromString(boardSizeStr),
            gameMode: GameMode.fromString(gameModeStr),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.statistics,
        name: AppRoutes.statisticsName,
        builder: (context, state) => const StatisticsScreen(),
      ),

      GoRoute(
        path: AppRoutes.settings,
        name: AppRoutes.settingsName,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.uri}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

extension NavigationExtension on BuildContext {
  void goHome() => go(AppRoutes.home);

  void goGame({
    BoardSize boardSize = BoardSize.classic,
    GameMode gameMode = GameMode.playerVsPlayer,
  }) {
    go(
      AppRoutes.gameWithParams(
        boardSize: boardSize == BoardSize.classic ? 'classic' : 'extended',
        gameMode: gameMode == GameMode.playerVsPlayer ? 'pvp' : 'pvc',
      ),
    );
  }

  void goStatistics() => go(AppRoutes.statistics);

  void goSettings() => go(AppRoutes.settings);
}
