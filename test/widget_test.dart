// Basic Flutter widget test for TicTacToe app.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:game_tictactoe/app.dart';

void main() {
  testWidgets('App renders placeholder screen', (WidgetTester tester) async {
    // Build our app with ProviderScope and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: TicTacToeApp(),
      ),
    );

    // Allow the widget tree to settle
    await tester.pumpAndSettle();

    // Verify that setup complete message is displayed
    expect(find.text('Setup Complete!'), findsOneWidget);

    // Verify that phase info is displayed
    expect(find.textContaining('Phase 1 Complete'), findsOneWidget);
  });
}
