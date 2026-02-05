import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game_tictactoe/main.dart' as app;
import 'package:game_tictactoe/presentation/screens/game/widgets/cell_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('Complete game flow - Player X wins', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('3x3'));
      await tester.pumpAndSettle();

      expect(find.byType(CellWidget), findsNWidgets(9));

      await tester.tap(find.byType(CellWidget).at(0));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CellWidget).at(3));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CellWidget).at(1));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CellWidget).at(4));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CellWidget).at(2));
      await tester.pumpAndSettle();

      expect(find.textContaining('Wins'), findsOneWidget);
      expect(find.text('Play Again'), findsOneWidget);
    });

    testWidgets('Navigation to statistics', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.bar_chart));
      await tester.pumpAndSettle();

      expect(find.text('Statistics'), findsOneWidget);
    });

    testWidgets('Navigation to settings', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Game mode selection flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Play'));
      await tester.pumpAndSettle();

      expect(find.text('Select Board Size'), findsOneWidget);

      await tester.tap(find.text('6x6'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Player vs Player'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Start Game'));
      await tester.pumpAndSettle();

      expect(find.byType(CellWidget), findsNWidgets(36));
    });

    testWidgets('Quick play 3x3 starts game', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('3x3'));
      await tester.pumpAndSettle();

      expect(find.byType(CellWidget), findsNWidgets(9));
    });

    testWidgets('Quick play 6x6 starts game', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('6x6'));
      await tester.pumpAndSettle();

      expect(find.byType(CellWidget), findsNWidgets(36));
    });

    testWidgets('CPU game starts correctly', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.computer));
      await tester.pumpAndSettle();

      expect(find.byType(CellWidget), findsNWidgets(9));
    });

    testWidgets('Draw game flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('3x3'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CellWidget).at(0));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CellWidget).at(1));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CellWidget).at(2));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CellWidget).at(4));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CellWidget).at(3));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CellWidget).at(5));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CellWidget).at(7));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CellWidget).at(6));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CellWidget).at(8));
      await tester.pumpAndSettle();

      expect(find.text('Draw'), findsOneWidget);
    });

    testWidgets('Play again after win', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('3x3'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CellWidget).at(0));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CellWidget).at(3));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CellWidget).at(1));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CellWidget).at(4));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CellWidget).at(2));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Play Again'));
      await tester.pumpAndSettle();

      expect(find.byType(CellWidget), findsNWidgets(9));
    });

    testWidgets('Back navigation from game', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('3x3'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
      await tester.pumpAndSettle();

      expect(find.text('Play'), findsOneWidget);
    });
  });
}
