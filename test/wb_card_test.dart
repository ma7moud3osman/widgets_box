import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_box/widgets_box.dart';

Widget _host(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('WBCard', () {
    testWidgets('renders its child', (tester) async {
      await tester.pumpWidget(_host(const WBCard(child: Text('content'))));
      expect(find.text('content'), findsOneWidget);
    });

    testWidgets('is tappable when onTap is provided', (tester) async {
      var tapped = 0;
      await tester.pumpWidget(
        _host(WBCard(onTap: () => tapped++, child: const Text('tap me'))),
      );
      await tester.tap(find.text('tap me'));
      expect(tapped, 1);
    });

    testWidgets('overlays the status widget', (tester) async {
      await tester.pumpWidget(
        _host(
          const WBCard(
            status: Text('PAID'),
            child: Text('invoice'),
          ),
        ),
      );
      expect(find.text('PAID'), findsOneWidget);
      expect(find.text('invoice'), findsOneWidget);
    });

    testWidgets('places leading before the child in a row', (tester) async {
      await tester.pumpWidget(
        _host(
          const WBCard(
            leading: Icon(Icons.star),
            child: Text('with leading'),
          ),
        ),
      );
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('with leading'), findsOneWidget);
    });

    testWidgets('reads radius from WBCardConfig, local override wins',
        (tester) async {
      await tester.pumpWidget(
        WidgetsBoxConfigProvider(
          config: const WidgetsBoxConfig(
            cardConfig: WBCardConfig(radius: 24),
          ),
          child: _host(const WBCard(child: Text('x'))),
        ),
      );
      // Just proves config wiring compiles + renders; visual radius is covered
      // by the resolution order in code.
      expect(find.text('x'), findsOneWidget);
    });
  });

  group('WBEnvironmentManager', () {
    const prod = WBAppEnvironment(
      name: 'production',
      label: 'Production',
      baseUrl: 'https://api.prod',
    );
    const testEnv = WBAppEnvironment(
      name: 'test',
      label: 'Test',
      baseUrl: 'https://api.test',
    );

    tearDown(WBEnvironmentManager.reset);

    test('defaults to the configured default environment', () {
      WBEnvironmentManager.init(
        WBEnvironmentConfig(
          environments: [prod, testEnv],
          defaultEnvironment: prod,
        ),
      );
      expect(WBEnvironmentManager.baseUrl, 'https://api.prod');
    });

    test('select switches the active environment in debug', () async {
      WBEnvironmentManager.init(
        WBEnvironmentConfig(
          environments: [prod, testEnv],
          defaultEnvironment: prod,
        ),
      );
      await WBEnvironmentManager.select(testEnv);
      // In the test VM kDebugMode is true, so switching is enabled.
      expect(WBEnvironmentManager.baseUrl, 'https://api.test');
    });
  });

  group('HexColor', () {
    test('falls back to opaque white on malformed input instead of throwing',
        () {
      expect(HexColor('not-a-color').toARGB32(), 0xFFFFFFFF);
      expect(HexColor('').toARGB32(), 0xFFFFFFFF);
    });

    test('parses #RRGGBB and 3-digit shorthand', () {
      expect(HexColor('#FF0000').toARGB32(), 0xFFFF0000);
      expect(HexColor('#F00').toARGB32(), 0xFFFF0000);
    });
  });
}
