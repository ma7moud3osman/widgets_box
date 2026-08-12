import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_box/widgets_box.dart';

void main() {
  group('WBWidgetExtension', () {
    testWidgets('toSliver renders inside a CustomScrollView', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CustomScrollView(
            slivers: [
              // A plain box widget promoted to a sliver.
              _Marker(),
            ],
          ),
        ),
      );
      expect(find.byType(_Marker), findsOneWidget);
    });

    testWidgets('visible(false) removes the widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: [
              const Text('shown').visible(true),
              const Text('hidden').visible(false),
            ],
          ),
        ),
      );
      expect(find.text('shown'), findsOneWidget);
      expect(find.text('hidden'), findsNothing);
    });
  });

  group('WBThemeMode extensions', () {
    test('round-trips through string', () {
      for (final mode in ThemeMode.values) {
        expect(mode.toThemeName.toThemeMode, mode);
      }
    });

    test('unknown string defaults to system', () {
      expect('nonsense'.toThemeMode, ThemeMode.system);
      expect(null.toThemeMode, ThemeMode.system);
    });
  });

  group('BuildContext extensions', () {
    testWidgets('language + tablet + media-query getters', (tester) async {
      late BuildContext ctx;
      await tester.pumpWidget(
        Localizations(
          locale: const Locale('ar'),
          delegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          child: MediaQuery(
            data: const MediaQueryData(
              size: Size(400, 800),
              viewPadding: EdgeInsets.only(top: 44, bottom: 34),
            ),
            child: Builder(builder: (context) {
              ctx = context;
              return const SizedBox();
            }),
          ),
        ),
      );
      expect(ctx.isArabic, isTrue);
      expect(ctx.isEnglish, isFalse);
      expect(ctx.width, 400);
      expect(ctx.height, 800);
      expect(ctx.topPadding, 44);
      expect(ctx.bottomPadding, 34);
      expect(ctx.isTablet, isFalse); // shortestSide 400 < 600
    });
  });

  group('WBValidators', () {
    test('required rejects empty, accepts value', () {
      expect(WBValidators.required(''), isNotNull);
      expect(WBValidators.required('x'), isNull);
    });

    test('email rejects malformed, accepts valid', () {
      expect(WBValidators.email('not-an-email'), isNotNull);
      expect(WBValidators.email('user@company.com'), isNull);
    });

    test('confirmPassword flags mismatch, passes match', () {
      expect(
        WBValidators.confirmPassword(password: 'abcdef', confirmPassword: 'x'),
        isNotNull,
      );
      expect(
        WBValidators.confirmPassword(
            password: 'abcdef', confirmPassword: 'abcdef'),
        isNull,
      );
    });
  });
}

class _Marker extends StatelessWidget {
  const _Marker();

  @override
  Widget build(BuildContext context) =>
      const SizedBox(height: 10, width: 10).toSliver;
}
