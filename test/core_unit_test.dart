import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_box/widgets_box.dart';

void main() {
  group('DateFormats.format', () {
    test('every enum value yields a non-empty pattern', () {
      for (final f in DateFormats.values) {
        expect(f.format, isNotEmpty, reason: '${f.name} has no pattern');
      }
    });
  });

  group('getFormatedDate / date helpers', () {
    const iso = '2023-11-03T11:00:00Z';

    test('returns empty string for null/unparseable input', () {
      expect(getFormatedDate(date: null), '');
      expect(getFormatedDate(date: 'not-a-date'), '');
    });

    test('formats a valid date for every DateFormats value without throwing',
        () {
      for (final f in DateFormats.values) {
        final out = getFormatedDate(date: iso, format: f);
        expect(out, isA<String>());
      }
    });

    test('honors toApi/isUTC/locale flags', () {
      expect(getFormatedDate(date: iso, format: DateFormats.year), '2023');
      expect(
        getFormatedDate(
          date: iso,
          format: DateFormats.year,
          toApi: false,
          isUTC: false,
        ),
        '2023',
      );
    });

    test('getTime parses 12h and 24h and rejects junk', () {
      expect(getTime(time: '11:00 PM'), isNotEmpty);
      expect(getTime(time: '12:00 AM'), isNotEmpty);
      expect(getTime(time: '13:30'), isNotEmpty);
      expect(getTime(time: null), '');
      expect(getTime(time: 'nope'), '');
    });

    test('getDurationDays counts inclusive days', () {
      expect(
        getDurationDays(date: '2023-11-01', secondDate: '2023-11-03'),
        3,
      );
      expect(getDurationDays(date: 'bad'), 1);
    });

    test('getDateTime returns a string (now-based fallback on junk)', () {
      expect(getDateTime(date: iso), isNotEmpty);
      expect(getDateTime(date: 'junk'), isNotEmpty);
    });

    test('daysBetween ignores time-of-day', () {
      final a = DateTime(2023, 11, 1, 23);
      final b = DateTime(2023, 11, 4, 1);
      expect(daysBetween(a, b), 3);
    });

    test('DateTime extensions', () {
      final d = DateTime(2023, 11, 3, 15, 30);
      expect(d.midnight, DateTime(2023, 11, 3));
      expect(d.endOfDay, DateTime(2023, 11, 3, 23, 59));
      expect(d.toApi, isNotEmpty);
    });
  });

  group('string / list / initials extensions', () {
    test('string date extensions', () {
      expect('2023-11-03T11:00:00Z'.toFormattedDate, contains('/'));
      expect('2023-11-03T11:00:00Z'.toTime, isNotEmpty);
      expect('2023-11-03T11:00:00Z'.toDateTime, isNotEmpty);
      expect(''.toFormattedDate, '');
    });

    test('parsePhoneNumber returns parts or null', () {
      expect('+201000000000'.parsePhoneNumber, isNotNull);
      expect('201000000000'.parsePhoneNumber?.countryCode, '+20');
      expect(''.parsePhoneNumber, isNull);
      expect('abc'.parsePhoneNumber, isNull);
    });

    test('initials takes up to two leading letters, uppercased', () {
      expect('ahmed osman'.initials, 'AO');
      expect('ahmed'.initials, 'A');
      expect(''.initials, '');
      expect('  spaced   name '.initials, 'SN');
    });

    test('list separated inserts a separator between items only', () {
      final out = <Widget>[
        const Text('a'),
        const Text('b'),
        const Text('c'),
      ].separated(separator: const Divider());
      expect(out.length, 5);
      expect(out[1], isA<Divider>());
    });
  });

  group('HexColor', () {
    test('parses 6- and 8-digit and shorthand, guards junk', () {
      expect(HexColor('#FF0000').toARGB32(), 0xFFFF0000);
      expect(HexColor('80FF0000').toARGB32(), 0x80FF0000);
      expect(HexColor('#0F0').toARGB32(), 0xFF00FF00);
      expect(HexColor(null).toARGB32(), 0xFFFFFFFF);
      expect(HexColor('zzz').toARGB32(), 0xFFFFFFFF);
      expect(HexColor.toHexString(const Color(0xFF112233)), 'ff112233');
    });
  });

  group('Debouncer', () {
    testWidgets('runs the latest action after the delay', (tester) async {
      final d = Debouncer(milliseconds: 50);
      var calls = 0;
      d.run(() => calls++);
      d.run(() => calls++); // cancels the first
      await tester.pump(const Duration(milliseconds: 80));
      expect(calls, 1);
      d.dispose();
    });

    testWidgets('cancel prevents the pending action', (tester) async {
      final d = Debouncer(milliseconds: 30);
      var calls = 0;
      d.run(() => calls++);
      d.cancel();
      await tester.pump(const Duration(milliseconds: 60));
      expect(calls, 0);
    });

    testWidgets('legacy runDebouncer still fires', (tester) async {
      var calls = 0;
      runDebouncer(() => calls++, milliseconds: 20);
      await tester.pump(const Duration(milliseconds: 40));
      expect(calls, 1);
    });
  });

  group('config classes', () {
    test('WidgetsBoxConfig.defaults are populated', () {
      const d = WidgetsBoxConfig.defaults;
      expect(d.width, 370);
      expect(d.height, 44);
      expect(d.radius, 8);
      expect(d.buttonConfig, isNotNull);
    });

    test('value equality + hashCode', () {
      expect(
        const ButtonConfig(radius: 8) == const ButtonConfig(radius: 8),
        isTrue,
      );
      expect(
        const ButtonConfig(radius: 8).hashCode,
        const ButtonConfig(radius: 8).hashCode,
      );
      expect(
        const TextFieldConfig(fillColor: Color(0xFF111111)) ==
            const TextFieldConfig(fillColor: Color(0xFF111111)),
        isTrue,
      );
      expect(
        const ToastConfig(maxLines: 2) == const ToastConfig(maxLines: 3),
        isFalse,
      );
      expect(
        const WBCardConfig(radius: 16) == const WBCardConfig(radius: 16),
        isTrue,
      );
      expect(
        const WidgetsBoxConfig(width: 1) == const WidgetsBoxConfig(width: 2),
        isFalse,
      );
      expect(
        const WidgetsBoxConfig(width: 1).hashCode,
        const WidgetsBoxConfig(width: 1).hashCode,
      );
    });

    testWidgets('provider yields defaults with no ancestor', (tester) async {
      late WidgetsBoxConfig resolved;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              resolved = WidgetsBoxConfigProvider.of(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(resolved.radius, 8);
    });

    testWidgets('provider yields the supplied config', (tester) async {
      late WidgetsBoxConfig resolved;
      await tester.pumpWidget(
        WidgetsBoxConfigProvider(
          config: const WidgetsBoxConfig(radius: 99),
          child: Builder(
            builder: (context) {
              resolved = WidgetsBoxConfigProvider.of(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(resolved.radius, 99);
    });
  });

  group('environment', () {
    const prod = WBAppEnvironment(
      name: 'production',
      label: 'Production',
      baseUrl: 'https://api.prod',
    );
    const staging = WBAppEnvironment(
      name: 'test',
      label: 'Test',
      baseUrl: 'https://api.test',
    );

    tearDown(WBEnvironmentManager.reset);

    test('AppEnvironment equality, hashCode, toString', () {
      expect(prod == const WBAppEnvironment(
        name: 'production',
        label: 'x',
        baseUrl: 'https://api.prod',
      ), isTrue);
      expect(prod.hashCode, isA<int>());
      expect(prod.toString(), contains('production'));
    });

    test('config throws before init', () {
      expect(() => WBEnvironmentManager.config, throwsStateError);
    });

    test('current falls back to a default before init', () {
      expect(WBEnvironmentManager.current.name, 'production');
    });

    test('init, loadPersisted, select and baseUrl', () async {
      WBEnvironmentManager.init(
        WBEnvironmentConfig(
          environments: [prod, staging],
          defaultEnvironment: prod,
          read: () => 'test',
        ),
      );
      expect(WBEnvironmentManager.isEnabled, isTrue);
      WBEnvironmentManager.loadPersisted();
      expect(WBEnvironmentManager.baseUrl, 'https://api.test');
      await WBEnvironmentManager.select(prod);
      expect(WBEnvironmentManager.current, prod);
    });

    test('loadPersisted with unknown name keeps default', () {
      WBEnvironmentManager.init(
        WBEnvironmentConfig(
          environments: [prod, staging],
          defaultEnvironment: prod,
          read: () => 'ghost',
        ),
      );
      WBEnvironmentManager.loadPersisted();
      expect(WBEnvironmentManager.current, prod);
    });
  });

  group('WBAppRestarter', () {
    testWidgets('remounts the subtree on restart', (tester) async {
      var initCount = 0;
      late BuildContext inner;
      await tester.pumpWidget(
        MaterialApp(
          home: WBAppRestarter(
            child: _Probe(
              onInit: () => initCount++,
              onBuild: (c) => inner = c,
            ),
          ),
        ),
      );
      expect(initCount, 1);
      WBAppRestarter.restart(inner);
      await tester.pump();
      expect(initCount, 2);
    });
  });
}

class _Probe extends StatefulWidget {
  final VoidCallback onInit;
  final void Function(BuildContext) onBuild;
  const _Probe({required this.onInit, required this.onBuild});

  @override
  State<_Probe> createState() => _ProbeState();
}

class _ProbeState extends State<_Probe> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    widget.onBuild(context);
    return const SizedBox();
  }
}
