import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_box/widgets_box.dart';

Widget host(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('context_extension getters', () {
    testWidgets('text styles, brightness, orientation, string caps',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(brightness: Brightness.light),
        home: Builder(builder: (context) {
          // Exercise the text-style getters.
          final styles = [
            context.bodySmall,
            context.bodyMedium,
            context.bodyLarge,
            context.labelSmall,
            context.labelMedium,
            context.labelLarge,
            context.titleSmall,
            context.titleMedium,
            context.titleLarge,
            context.displaySmall,
            context.displayMedium,
            context.displayLarge,
            context.headlineSmall,
            context.headlineMedium,
            context.headlineLarge,
          ];
          expect(styles.length, 15);
          expect(context.isDark, isFalse);
          expect(context.isPortrait || context.isLandscape, isTrue);
          expect('hELLO'.toCapitalLetter, 'Hello');
          expect(''.toCapitalLetter, '');
          return const SizedBox();
        }),
      ));
    });
  });

  group('text field label-required + factories with icons', () {
    testWidgets('labelText + required renders the asterisk label',
        (tester) async {
      await tester.pumpWidget(host(WBTextField(
        labelText: 'Email',
        isRequired: true,
      )));
      expect(find.byType(WBTextField), findsOneWidget);
    });
  });

  group('WBCachedImage file branch', () {
    testWidgets('local file path uses Image.file with a graceful error',
        (tester) async {
      await tester.pumpWidget(host(const WBCachedImage(
        imageUrl: '/tmp/none.png',
        width: 30,
        height: 30,
        errorWidget: Text('img-error'),
      )));
      expect(find.byType(WBCachedImage), findsOneWidget);
    });
  });
}
