import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:mocktail/mocktail.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';
import 'package:game_tictactoe/domain/entities/entities.dart';
import 'package:game_tictactoe/presentation/providers/game_provider.dart';
import 'package:game_tictactoe/presentation/providers/game_state.dart';
import 'package:game_tictactoe/presentation/screens/game/widgets/board_widget.dart';
import 'package:game_tictactoe/presentation/screens/game/widgets/cell_widget.dart';
import 'package:game_tictactoe/data/repositories/game_repository.dart';
import 'package:game_tictactoe/core/di/providers.dart';

class MockGameRepository extends Mock implements GameRepository {}

void main() {
  late MockGameRepository mockRepository;

  setUp(() {
    mockRepository = MockGameRepository();
  });

  Widget createWidget({BoardSize boardSize = BoardSize.classic}) {
    final game = GameEntity.newGame(
      boardSize: boardSize,
      mode: GameMode.playerVsPlayer,
    );

    final initialState = GameState(game: game);

    return ProviderScope(
      overrides: [
        gameRepositoryProvider.overrideWithValue(mockRepository),
        gameProvider.overrideWith(() => _TestGameNotifier(initialState)),
      ],
      child: const NeumorphicApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: BoardWidget(),
            ),
          ),
        ),
      ),
    );
  }

  group('BoardWidget', () {
    testWidgets('should render 9 cells for 3x3 board', (tester) async {
      await tester.pumpWidget(createWidget(boardSize: BoardSize.classic));
      await tester.pumpAndSettle();

      expect(find.byType(CellWidget), findsNWidgets(9));
    });

    testWidgets('should render 36 cells for 6x6 board', (tester) async {
      await tester.pumpWidget(createWidget(boardSize: BoardSize.extended));
      await tester.pumpAndSettle();

      expect(find.byType(CellWidget), findsNWidgets(36));
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
