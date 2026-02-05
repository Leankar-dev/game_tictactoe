import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:game_tictactoe/presentation/widgets/neumorphic_button.dart';

void main() {
  Widget createWidget({required Widget child}) {
    return NeumorphicApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('NeumorphicButtonWidget', () {
    testWidgets('should display text', (tester) async {
      await tester.pumpWidget(
        createWidget(
          child: NeumorphicButtonWidget(text: 'Test Button', onPressed: () {}),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('should display icon when provided', (tester) async {
      await tester.pumpWidget(
        createWidget(
          child: NeumorphicButtonWidget(
            text: 'With Icon',
            icon: Icons.play_arrow,
            onPressed: () {},
          ),
        ),
      );

      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        createWidget(
          child: NeumorphicButtonWidget(
            text: 'Tap Me',
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pumpAndSettle();

      expect(pressed, true);
    });

    testWidgets('should show loading indicator when isLoading', (tester) async {
      await tester.pumpWidget(
        createWidget(
          child: NeumorphicButtonWidget(
            text: 'Loading',
            onPressed: () {},
            isLoading: true,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('should not call onPressed when disabled', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        createWidget(
          child: NeumorphicButtonWidget(
            text: 'Disabled',
            onPressed: () => pressed = true,
            isDisabled: true,
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      await tester.pumpAndSettle();

      expect(pressed, false);
    });

    testWidgets('should create primary variant', (tester) async {
      await tester.pumpWidget(
        createWidget(
          child: NeumorphicButtonWidget.primary(
            text: 'Primary',
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
    });

    testWidgets('should create secondary variant', (tester) async {
      await tester.pumpWidget(
        createWidget(
          child: NeumorphicButtonWidget.secondary(
            text: 'Secondary',
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Secondary'), findsOneWidget);
    });

    testWidgets('should create danger variant', (tester) async {
      await tester.pumpWidget(
        createWidget(
          child: NeumorphicButtonWidget.danger(
            text: 'Danger',
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Danger'), findsOneWidget);
    });
  });

  group('NeumorphicIconButton', () {
    testWidgets('should display icon', (tester) async {
      await tester.pumpWidget(
        createWidget(
          child: NeumorphicIconButton(icon: Icons.settings, onPressed: () {}),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        createWidget(
          child: NeumorphicIconButton(
            icon: Icons.settings,
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      expect(pressed, true);
    });

    testWidgets('should not call onPressed when disabled', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        createWidget(
          child: NeumorphicIconButton(
            icon: Icons.settings,
            onPressed: () => pressed = true,
            isDisabled: true,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      expect(pressed, false);
    });
  });
}
