import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/neumorphic_theme.dart';
// TODO: Import router when navigation is implemented
// import 'routes/app_router.dart';

/// Root widget of the application.
/// Configures Neumorphic theme and routing.
class TicTacToeApp extends ConsumerWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NeumorphicApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      // Neumorphic Theme Configuration
      themeMode: ThemeMode.light,
      theme: AppNeumorphicTheme.themeData,
      darkTheme: AppNeumorphicTheme.darkThemeData,

      // Material Theme (for Material widgets)
      materialTheme: AppTheme.lightTheme,
      materialDarkTheme: AppTheme.darkTheme,

      // TODO: Replace with GoRouter when navigation is implemented
      // routerConfig: ref.watch(appRouterProvider),

      // Temporary home screen placeholder
      home: const _PlaceholderHomeScreen(),
    );
  }
}

/// Temporary placeholder screen until HomeScreen is implemented.
/// Will be replaced with GoRouter navigation in Phase 8.
class _PlaceholderHomeScreen extends StatelessWidget {
  const _PlaceholderHomeScreen();

  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeumorphicText(
                AppStrings.appName,
                style: const NeumorphicStyle(
                  depth: 4,
                  color: Color(0xFF2D3436),
                ),
                textStyle: NeumorphicTextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Neumorphic(
                style: NeumorphicStyle(
                  depth: 8,
                  intensity: 0.5,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                child: const Text(
                  'Setup Complete!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF636E72),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              const Text(
                'Phase 1 Complete\nProceed to Phase 2: Domain Layer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF95A5A6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
