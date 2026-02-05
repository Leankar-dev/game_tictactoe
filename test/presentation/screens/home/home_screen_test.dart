import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:game_tictactoe/presentation/screens/home/home_screen.dart';

void main() {
  Widget createWidget() {
    return const ProviderScope(child: NeumorphicApp(home: HomeScreen()));
  }

  group('HomeScreen', () {
    testWidgets('should display play button with icon', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidget());

      expect(find.text('Play'), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });

    testWidgets('should display quick play options', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidget());

      expect(find.text('3x3'), findsOneWidget);
      expect(find.text('6x6'), findsOneWidget);
    });

    testWidgets('should display quick play labels', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidget());

      expect(find.text('Classic'), findsOneWidget);
      expect(find.text('Extended'), findsOneWidget);
      expect(find.text('CPU'), findsOneWidget);
    });

    testWidgets('should display bottom navigation buttons', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidget());

      expect(find.byIcon(Icons.bar_chart), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('should display Quick Play text', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidget());

      expect(find.text('Quick Play'), findsOneWidget);
    });

    testWidgets('should display vs CPU option', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidget());

      expect(find.byIcon(Icons.computer), findsOneWidget);
    });

    testWidgets('should show mode selector on play tap', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidget());

      await tester.tap(find.text('Play'));
      await tester.pumpAndSettle();

      expect(find.text('Select Board Size'), findsOneWidget);
    });
  });
}
