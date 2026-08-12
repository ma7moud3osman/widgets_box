import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_box/widgets_box.dart';

Widget host(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('environment switcher', () {
    tearDown(WBEnvironmentManager.reset);

    testWidgets('opens, lists options, selects and reinitializes',
        (tester) async {
      const prod = WBAppEnvironment(
          name: 'production', label: 'Prod', baseUrl: 'https://p');
      const testEnv =
          WBAppEnvironment(name: 'test', label: 'Test', baseUrl: 'https://t');
      var reinit = 0;
      late BuildContext rootCtx;

      await tester.pumpWidget(WBAppRestarter(
        child: MaterialApp(
          home: Builder(builder: (c) {
            rootCtx = c;
            return Scaffold(
              body: Builder(
                builder: (ctx) => ElevatedButton(
                  onPressed: () => WBEnvironmentSwitcher.show(
                    ctx,
                    title: 'Env',
                    subtitle: 'switch',
                  ),
                  child: const Text('open'),
                ),
              ),
            );
          }),
        ),
      ));

      WBEnvironmentManager.init(WBEnvironmentConfig(
        environments: [prod, testEnv],
        defaultEnvironment: prod,
        onReinitialize: () async => reinit++,
        restartContext: () => rootCtx,
      ));

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.text('Env'), findsOneWidget);
      expect(find.text('Prod'), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);

      await tester.tap(find.text('Test'));
      await tester.pumpAndSettle();
      expect(reinit, 1);
      expect(WBEnvironmentManager.baseUrl, 'https://t');
    });

    testWidgets('re-selecting the current env just closes', (tester) async {
      const prod = WBAppEnvironment(
          name: 'production', label: 'Prod', baseUrl: 'https://p');
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (ctx) {
          return Scaffold(
            body: ElevatedButton(
              onPressed: () => WBEnvironmentSwitcher.show(ctx),
              child: const Text('open'),
            ),
          );
        }),
      ));
      WBEnvironmentManager.init(WBEnvironmentConfig(
        environments: const [prod],
        defaultEnvironment: prod,
      ));
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Prod'));
      await tester.pumpAndSettle();
      expect(find.text('Prod'), findsNothing); // sheet closed
    });

    testWidgets('show is a no-op when disabled (no config)', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (ctx) {
          return Scaffold(
            body: ElevatedButton(
              onPressed: () => WBEnvironmentSwitcher.show(ctx),
              child: const Text('open'),
            ),
          );
        }),
      ));
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.byType(ElevatedButton), findsOneWidget); // nothing opened
    });
  });

  group('WBWelcome', () {
    testWidgets('renders greeting + first name', (tester) async {
      await tester.pumpWidget(host(const WBWelcome(
        firstName: 'Ahmed',
        lastName: 'Osman',
        userImage: '',
      )));
      expect(find.textContaining('Ahmed'), findsOneWidget);
    });
  });

  group('WBTag', () {
    testWidgets('renders', (tester) async {
      await tester.pumpWidget(host(const WBTag(text: 'tag')));
      expect(find.text('tag'), findsOneWidget);
    });
  });

  group('WBCard branches', () {
    testWidgets('bordered / flat / media / fixed-size', (tester) async {
      await tester.pumpWidget(host(Column(children: [
        const WBCard(style: WBCardStyle.bordered, child: Text('b')),
        const WBCard(style: WBCardStyle.flat, child: Text('f')),
        WBCard(
          width: 120,
          height: 60,
          margin: const EdgeInsets.all(4),
          alignment: Alignment.center,
          child: const Text('sized'),
        ),
        WBCard.media(
          image: const SizedBox(width: 40, height: 40),
          status: const WBStatusBadge(label: 'S'),
          child: const Text('m'),
        ),
      ])));
      expect(find.text('sized'), findsOneWidget);
      expect(find.text('m'), findsOneWidget);
    });
  });

  group('WBListRow branches', () {
    testWidgets('picker / selected / bordered', (tester) async {
      await tester.pumpWidget(host(Column(children: [
        WBListRow.picker(label: 'Warehouse', value: 'Main', onTap: () {}),
        const WBListRow(title: 'sel', selected: true),
        const WBListRow(title: 'bordered', bordered: true),
        const WBListRow(title: 'destructive', destructive: true),
      ])));
      expect(find.text('Main'), findsOneWidget);
      expect(find.text('sel'), findsOneWidget);
    });
  });

  group('WBSectionHeader branches', () {
    testWidgets('leading + required + badge + upperCase + trailing',
        (tester) async {
      await tester.pumpWidget(host(Column(children: [
        WBSectionHeader(
          title: 'a',
          leading: const Icon(Icons.star),
          isRequired: true,
          titleBadge: const WBStatusBadge(label: '3'),
          upperCase: true,
          subtitle: 'sub',
        ),
        WBSectionHeader(title: 'b', trailing: const Icon(Icons.more_vert)),
      ])));
      expect(find.text('A'), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });
  });

  group('WBDetailRow branches', () {
    testWidgets('vertical / phone / onTap / valueIcon / flex / leadingIcon',
        (tester) async {
      var taps = 0;
      await tester.pumpWidget(host(Column(children: [
        const WBDetailRow(
          label: 'v',
          value: 'x',
          axis: WBDetailAxis.vertical,
          emphasized: true,
        ),
        WBDetailRow(
          label: 'phone',
          value: '+20100',
          isPhone: true,
          valueIcon: Icons.phone,
          onTap: () => taps++,
          labelFlex: 2,
          valueFlex: 3,
          leadingIcon: Icons.info,
          valueColor: Colors.red,
        ),
      ])));
      await tester.tap(find.text('+20100'));
      expect(taps, 1);
    });
  });

  group('config equality covers all fields', () {
    test('non-identical equal + per-field differences', () {
      // Non-const so `identical` is false and every field comparison executes.
      expect(WBCardConfig(radius: 16) == WBCardConfig(radius: 16.0), isTrue);
      expect(
        WBCardConfig(radius: 16) == WBCardConfig(radius: 17),
        isFalse,
      );
      expect(
        ButtonConfig(radius: 8, height: 44) ==
            ButtonConfig(radius: 8, height: 44.0),
        isTrue,
      );
      expect(
        TextFieldConfig(width: 300, iconSize: 20) ==
            TextFieldConfig(width: 300, iconSize: 20.0),
        isTrue,
      );
      expect(
        ToastConfig(radius: 12, maxLines: 2) ==
            ToastConfig(radius: 12, maxLines: 2),
        isTrue,
      );
      expect(
        WidgetsBoxConfig(width: 1, height: 2) ==
            WidgetsBoxConfig(width: 1, height: 2.0),
        isTrue,
      );
      // hashCodes are stable for equal values.
      expect(
        WBCardConfig(radius: 16).hashCode,
        WBCardConfig(radius: 16).hashCode,
      );
    });
  });
}
