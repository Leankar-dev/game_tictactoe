import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:game_tictactoe/domain/enums/player_type.dart';
import 'package:game_tictactoe/presentation/screens/game/widgets/cell_widget.dart';

void main() {
  Widget createWidget({
    PlayerType player = PlayerType.none,
    bool isWinningCell = false,
    bool isEnabled = true,
    VoidCallback? onTap,
  }) {
    return NeumorphicApp(
      home: Scaffold(
        body: Center(
          child: CellWidget(
            player: player,
            isWinningCell: isWinningCell,
            isEnabled: isEnabled,
            onTap: onTap,
            animate: false,
          ),
        ),
      ),
    );
  }

  group('CellWidget', () {
    testWidgets('should render empty cell', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(CellWidget), findsOneWidget);
    });

    testWidgets('should render X symbol', (tester) async {
      await tester.pumpWidget(createWidget(player: PlayerType.x));

      await tester.pumpAndSettle();

      expect(find.byType(CellWidget), findsOneWidget);
      expect(find.byType(CustomPaint), findsAtLeast(1));
    });

    testWidgets('should render O symbol', (tester) async {
      await tester.pumpWidget(createWidget(player: PlayerType.o));

      await tester.pumpAndSettle();

      expect(find.byType(CellWidget), findsOneWidget);
      expect(find.byType(CustomPaint), findsAtLeast(1));
    });

    testWidgets('should call onTap when empty and enabled', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        createWidget(
          player: PlayerType.none,
          isEnabled: true,
          onTap: () => tapped = true,
        ),
      );

      await tester.tap(find.byType(CellWidget));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('should not call onTap when occupied', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        createWidget(
          player: PlayerType.x,
          isEnabled: true,
          onTap: () => tapped = true,
        ),
      );

      await tester.tap(find.byType(CellWidget));
      await tester.pump();

      expect(tapped, false);
    });

    testWidgets('should not call onTap when disabled', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        createWidget(
          player: PlayerType.none,
          isEnabled: false,
          onTap: () => tapped = true,
        ),
      );

      await tester.tap(find.byType(CellWidget));
      await tester.pump();

      expect(tapped, false);
    });
  });
}
