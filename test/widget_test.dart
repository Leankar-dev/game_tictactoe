import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:game_tictactoe/app.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const ProviderScope(child: TicTacToeApp()));
    await tester.pumpAndSettle();

    expect(find.text('Play'), findsOneWidget);
  });
}
