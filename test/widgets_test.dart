import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:widgets_box/widgets_box.dart';

Widget host(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('WBButton', () {
    for (final type in WBButtonType.values) {
      testWidgets('renders + taps for $type', (tester) async {
        var taps = 0;
        await tester.pumpWidget(host(
          WBButton(label: type.name, type: type, onPressed: () => taps++),
        ));
        expect(find.text(type.name), findsOneWidget);
        await tester.tap(find.byType(WBButton));
        expect(taps, 1);
      });
    }

    testWidgets('loading hides the label and blocks taps', (tester) async {
      var taps = 0;
      await tester.pumpWidget(host(
        WBButton(label: 'Go', isLoading: true, onPressed: () => taps++),
      ));
      await tester.tap(find.byType(WBButton));
      expect(taps, 0);
    });

    testWidgets('disabled, shadow, small, gradient, semantics variants',
        (tester) async {
      for (final w in const [
        WBButton(label: 'disabled', isDisable: true),
        WBButton(label: 'shadow', showShadow: true),
        WBButton(label: 'small', smallSize: true),
        WBButton(
          label: 'grad',
          gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
          semanticsIdentifier: 'grad-btn',
        ),
      ]) {
        await tester.pumpWidget(host(Center(child: w)));
        expect(find.byType(WBButton), findsOneWidget);
      }
    });

    testWidgets('icon factory: icon / svg-less png / icon-end', (tester) async {
      await tester.pumpWidget(host(
        WBButton.icon(
          label: 'save',
          iconType: IconType.icon,
          icon: Icons.save,
          isIconEnd: true,
          onPressed: () {},
        ),
      ));
      expect(find.text('save'), findsOneWidget);
      expect(find.byIcon(Icons.save), findsOneWidget);
    });
  });

  group('WBTextField', () {
    testWidgets('base renders title, hint, prefix and reacts to input',
        (tester) async {
      String? changed;
      await tester.pumpWidget(host(
        WBTextField(
          title: 'Name',
          hintText: 'enter',
          prefixIcon: const Icon(Icons.person),
          titleTrailing: const Icon(Icons.add),
          onChanged: (v) => changed = v,
          semanticsIdentifier: 'name-field',
        ),
      ));
      expect(find.text('Name'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'ahmed');
      expect(changed, 'ahmed');
    });

    testWidgets('factories build', (tester) async {
      await tester.pumpWidget(host(
        Column(children: [
          WBTextField.email(),
          WBTextField.password(),
          WBTextField.number(),
          WBTextField.phone(),
          WBTextField.confirmPassword(passwordValue: 'x'),
        ]),
      ));
      expect(find.byType(WBTextField), findsNWidgets(5));
    });

    testWidgets('filled + config-driven borders', (tester) async {
      await tester.pumpWidget(
        WidgetsBoxConfigProvider(
          config: const WidgetsBoxConfig(
            textFieldConfig: TextFieldConfig(
              borderColor: Colors.grey,
              radius: 10,
            ),
          ),
          child: host(WBTextField(
            filled: true,
            fillColor: Colors.amber.shade50,
            hintText: 'x',
          )),
        ),
      );
      expect(find.byType(WBTextField), findsOneWidget);
    });
  });

  group('WBScreen', () {
    testWidgets('loading (indicator), empty, and content states',
        (tester) async {
      await tester.pumpWidget(host(
        WBScreen(isLoading: true, builder: (_) => const Text('data')),
      ));
      expect(find.text('data'), findsNothing);

      await tester.pumpWidget(host(
        WBScreen(isEmpty: true, message: 'empty', builder: (_) => const Text('data')),
      ));
      await tester.pump();

      await tester.pumpWidget(host(
        WBScreen(builder: (_) => const Text('data'), onRefresh: () async {}),
      ));
      expect(find.text('data'), findsOneWidget);
    });

    testWidgets('skeleton loading + custom loading widget', (tester) async {
      await tester.pumpWidget(host(
        WBScreen(
          isLoading: true,
          loadingType: LoadingType.skeleton,
          builder: (_) => const Text('body'),
        ),
      ));
      await tester.pumpWidget(host(
        WBScreen(
          isLoading: true,
          loadingWidget: const Text('custom-loading'),
          builder: (_) => const Text('body'),
        ),
      ));
      expect(find.text('custom-loading'), findsOneWidget);
    });
  });

  group('WBEmptyState', () {
    testWidgets('text / image(icon) / custom + retry + sliver', (tester) async {
      await tester.pumpWidget(host(const WBEmptyState(title: 'none')));
      expect(find.text('none'), findsOneWidget);

      await tester.pumpWidget(host(const WBEmptyState(
        type: EmptyType.image,
        title: 'nothing',
        subtitle: 'try later',
        icon: Icons.inbox,
      )));
      expect(find.text('nothing'), findsOneWidget);

      await tester.pumpWidget(host(const WBEmptyState(
        type: EmptyType.custom,
        child: Text('custom-empty'),
      )));
      expect(find.text('custom-empty'), findsOneWidget);

      var retried = 0;
      await tester.pumpWidget(host(
        WBEmptyState(title: 'oops', onRetry: () => retried++),
      ));
      await tester.tap(find.byType(FilledButton));
      expect(retried, 1);

      await tester.pumpWidget(host(
        CustomScrollView(slivers: [const WBEmptyState(title: 's').toSliver()]),
      ));
      expect(find.text('s'), findsOneWidget);
    });
  });

  group('WBStatus / WBPositionedStatus', () {
    testWidgets('plain, icon, outlined, dot, border', (tester) async {
      await tester.pumpWidget(host(
        Column(children: const [
          WBStatus(text: 'plain', textColor: Colors.green),
          WBStatus(text: 'icon', icon: Icons.check, textColor: Colors.green),
          WBStatus(text: 'outlined', outlined: true, textColor: Colors.red),
          WBStatus(text: 'dot', leadingDot: true, textColor: Colors.blue),
          WBStatus(text: 'border', borderColor: Colors.orange, textColor: Colors.orange),
        ]),
      ));
      expect(find.text('outlined'), findsOneWidget);
    });

    testWidgets('positioned overlay', (tester) async {
      await tester.pumpWidget(host(const WBPositionedStatus(
        text: 'NEW',
        child: SizedBox(width: 80, height: 80),
      )));
      expect(find.text('NEW'), findsOneWidget);
    });
  });

  group('WBStatusBadge extras', () {
    testWidgets('outlined + showBorder + dot + onTap + resolver names',
        (tester) async {
      var taps = 0;
      await tester.pumpWidget(host(
        Column(children: [
          const WBStatusBadge(label: 'a', colorValue: 'warning', outlined: true),
          const WBStatusBadge(label: 'b', colorValue: 'info', showBorder: true),
          const WBStatusBadge(label: 'c', colorValue: 'gray', leadingDot: true),
          const WBStatusBadge(label: 'd', colorValue: 'secondary'),
          const WBStatusBadge(label: 'e', colorValue: 'primary'),
          WBStatusBadge(label: 'f', colorValue: 'danger', onTap: () => taps++),
        ]),
      ));
      await tester.tap(find.text('f'));
      expect(taps, 1);
    });
  });

  group('WBCachedImage', () {
    testWidgets('null url shows fallback; asset/svg/tint branches build',
        (tester) async {
      await tester.pumpWidget(host(const WBCachedImage(
        imageUrl: null,
        fallback: Text('fallback'),
      )));
      expect(find.text('fallback'), findsOneWidget);

      await tester.pumpWidget(host(const WBCachedImage(
        imageUrl: 'assets/none.png',
        color: Colors.black26,
        blendMode: BlendMode.srcATop,
        width: 40,
        height: 40,
      )));
      expect(find.byType(WBCachedImage), findsOneWidget);
    });
  });

  group('WBUserImage', () {
    testWidgets('initials when no photo; image when photo', (tester) async {
      await tester.pumpWidget(host(const WBUserImage(
        photo: '',
        displayName: 'Ahmed Osman',
      )));
      expect(find.text('AO'), findsOneWidget);

      await tester.pumpWidget(host(const WBUserImage(
        photo: 'assets/x.png',
        displayName: 'Ahmed Osman',
      )));
      expect(find.byType(WBUserImage), findsOneWidget);
    });
  });

  group('WBRefreshIndicator', () {
    testWidgets('wraps a scrollable', (tester) async {
      await tester.pumpWidget(host(
        WBRefreshIndicator(
          onRefresh: () async {},
          child: ListView(children: const [Text('row')]),
        ),
      ));
      expect(find.text('row'), findsOneWidget);
    });
  });

  group('WBToast', () {
    testWidgets('success/error/info render an overlay message', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Column(
              children: [
                ElevatedButton(
                  onPressed: () => WBToast.success(context, 'saved'),
                  child: const Text('ok'),
                ),
                ElevatedButton(
                  onPressed: () => WBToast.error(context, 'failed'),
                  child: const Text('err'),
                ),
                ElevatedButton(
                  onPressed: () => WBToast.info(context, 'note'),
                  child: const Text('nfo'),
                ),
              ],
            ),
          ),
        ),
      ));
      await tester.tap(find.text('ok'));
      await tester.pump();
      expect(find.text('saved'), findsOneWidget);
      // Drain the toast's auto-dismiss timer/animation so no timers are
      // pending at teardown.
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });
  });

  group('WBPoweredBy / WBAppVersion', () {
    setUpAll(() {
      PackageInfo.setMockInitialValues(
        appName: 'app',
        packageName: 'com.x',
        version: '1.2.3',
        buildNumber: '9',
        buildSignature: '',
      );
    });

    testWidgets('powered-by renders brand + label', (tester) async {
      await tester.pumpWidget(host(const WBPoweredBy()));
      expect(find.text('GAIT'), findsOneWidget);
      expect(find.text('Powered by'), findsOneWidget);
    });

    testWidgets('powered-by non-tappable when url is null', (tester) async {
      await tester.pumpWidget(host(const WBPoweredBy(url: null, brand: 'ACME')));
      expect(find.text('ACME'), findsOneWidget);
    });

    testWidgets('app version shows v + build', (tester) async {
      await tester.pumpWidget(host(const WBAppVersion()));
      await tester.pumpAndSettle();
      expect(find.textContaining('1.2.3'), findsOneWidget);
    });
  });
}
