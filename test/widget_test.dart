// Basic Flutter widget test for TicTacToe app.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:game_tictactoe/app.dart';
import 'package:game_tictactoe/core/constants/app_strings.dart';

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

    // Verify that under construction message is displayed
    expect(find.text(AppStrings.underConstruction), findsOneWidget);

    // Verify that under construction detail message is displayed
    expect(find.text(AppStrings.underConstructionMessage), findsOneWidget);
  });
}
