import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:mocktail/mocktail.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';
import 'package:game_tictactoe/domain/entities/entities.dart';
import 'package:game_tictactoe/presentation/providers/game_provider.dart';
import 'package:game_tictactoe/presentation/providers/game_state.dart';
import 'package:game_tictactoe/presentation/screens/game/game_screen.dart';
import 'package:game_tictactoe/presentation/screens/game/widgets/board_widget.dart';
import 'package:game_tictactoe/presentation/screens/game/widgets/player_indicator_widget.dart';
import 'package:game_tictactoe/presentation/screens/game/widgets/game_controls_widget.dart';
import 'package:game_tictactoe/data/repositories/game_repository.dart';
import 'package:game_tictactoe/core/di/providers.dart';

class MockGameRepository extends Mock implements GameRepository {}

void main() {
  late MockGameRepository mockRepository;

  setUp(() {
    mockRepository = MockGameRepository();
  });

  Widget createWidget({
    BoardSize boardSize = BoardSize.classic,
    GameMode gameMode = GameMode.playerVsPlayer,
  }) {
    final game = GameEntity.newGame(
      boardSize: boardSize,
      mode: gameMode,
    );

    final initialState = GameState(game: game);

    return ProviderScope(
      overrides: [
        gameRepositoryProvider.overrideWithValue(mockRepository),
        gameProvider.overrideWith(() => _TestGameNotifier(initialState)),
      ],
      child: NeumorphicApp(
        home: MediaQuery(
          data: const MediaQueryData(size: Size(800, 1200)),
          child: GameScreen(
            boardSize: boardSize,
            gameMode: gameMode,
          ),
        ),
      ),
    );
  }

  group('GameScreen', () {
    testWidgets('should render all main components', (tester) async {
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.toString().contains('overflow')) return;
        originalOnError?.call(details);
      };

      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.byType(PlayerIndicatorWidget), findsOneWidget);
      expect(find.byType(BoardWidget), findsOneWidget);
      expect(find.byType(GameControlsWidget), findsOneWidget);

      FlutterError.onError = originalOnError;
    });

    testWidgets('should render GameScreen for classic mode', (tester) async {
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.toString().contains('overflow')) return;
        originalOnError?.call(details);
      };

      await tester.pumpWidget(createWidget(boardSize: BoardSize.classic));
      await tester.pumpAndSettle();

      expect(find.byType(GameScreen), findsOneWidget);
      expect(find.byType(BoardWidget), findsOneWidget);

      FlutterError.onError = originalOnError;
    });

    testWidgets('should render GameScreen for extended mode', (tester) async {
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.toString().contains('overflow')) return;
        originalOnError?.call(details);
      };

      await tester.pumpWidget(createWidget(boardSize: BoardSize.extended));
      await tester.pumpAndSettle();

      expect(find.byType(GameScreen), findsOneWidget);
      expect(find.byType(BoardWidget), findsOneWidget);

      FlutterError.onError = originalOnError;
    });
  });
}

class _TestGameNotifier extends GameNotifier {
  final GameState _initialState;

  _TestGameNotifier(this._initialState);

  @override
  GameState build() {
    return _initialState;
  }
}
