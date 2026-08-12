import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_box/widgets_box.dart';

Widget host(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('WBDetailRow.money formatting edge cases', () {
    Future<void> pumpMoney(WidgetTester t, num v) =>
        t.pumpWidget(host(WBDetailRow.money(label: 'x', value: v)));

    testWidgets('zero', (t) async {
      await pumpMoney(t, 0);
      expect(find.text('0'), findsOneWidget);
    });
    testWidgets('drops .00 and groups thousands', (t) async {
      await pumpMoney(t, 1000000);
      expect(find.text('1,000,000'), findsOneWidget);
    });
    testWidgets('keeps real decimals', (t) async {
      await pumpMoney(t, 1234567.89);
      expect(find.text('1,234,567.89'), findsOneWidget);
    });
    testWidgets('negative', (t) async {
      await pumpMoney(t, -5000);
      expect(find.text('-5,000'), findsOneWidget);
    });
    testWidgets('small below thousand', (t) async {
      await pumpMoney(t, 42);
      expect(find.text('42'), findsOneWidget);
    });
  });

  group('WBStatusBadge edge cases', () {
    testWidgets('empty label without hide still renders a pill', (t) async {
      await t.pumpWidget(host(const WBStatusBadge(label: '')));
      expect(find.byType(WBStatusBadge), findsOneWidget);
    });
    testWidgets('null colorValue falls back to primary', (t) async {
      await t.pumpWidget(host(const WBStatusBadge(label: 'x')));
      expect(find.text('x'), findsOneWidget);
    });
    testWidgets('unknown color name is treated as hex fallback', (t) async {
      await t.pumpWidget(host(const WBStatusBadge(label: 'x', colorValue: 'zzz')));
      expect(find.text('x'), findsOneWidget);
    });
  });

  group('initials edge cases', () {
    test('single, multi-space, long, unicode-ish', () {
      expect('A'.initials, 'A');
      expect('   '.initials, '');
      expect('a b c d'.initials, 'AB');
      expect('john   doe'.initials, 'JD');
    });
  });

  group('HexColor edge cases', () {
    test('with/without hash, 3/6/8 digits, junk', () {
      expect(HexColor('FF0000').toARGB32(), 0xFFFF0000);
      expect(HexColor('#abc').toARGB32(), 0xFFAABBCC);
      expect(HexColor('#80000000').toARGB32(), 0x80000000);
      expect(HexColor('#12').toARGB32(), 0xFFFFFFFF); // invalid length → white
    });
  });

  group('minimal / null-ish widget construction', () {
    testWidgets('bare widgets build without optional params', (t) async {
      await t.pumpWidget(host(Column(children: const [
        WBCard(child: Text('c')),
        WBListRow(title: 'r'),
        WBSectionHeader(title: 'h'),
        WBDetailRow(label: 'l'),
        WBStatus(text: 's'),
      ])));
      expect(find.text('c'), findsOneWidget);
      expect(find.text('r'), findsOneWidget);
    });

    testWidgets('WBCachedImage whitespace url shows fallback', (t) async {
      await t.pumpWidget(host(const WBCachedImage(
        imageUrl: '   ',
        fallback: Text('fb'),
      )));
      expect(find.text('fb'), findsOneWidget);
    });
  });

  group('new Flutter-property pass-throughs are accepted', () {
    testWidgets('WBTextField exposes extended props', (t) async {
      final scroll = ScrollController();
      await t.pumpWidget(host(WBTextField(
        keyboardAppearance: Brightness.dark,
        scrollController: scroll,
        scrollPadding: const EdgeInsets.all(4),
        showCursor: true,
        cursorWidth: 3,
        cursorRadius: const Radius.circular(2),
        autocorrect: false,
        enableSuggestions: false,
        restorationId: 'field-1',
        mouseCursor: SystemMouseCursors.text,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      )));
      expect(find.byType(WBTextField), findsOneWidget);
      scroll.dispose();
    });

    testWidgets('WBButton exposes long-press / focus / autofocus',
        (t) async {
      var long = 0;
      await t.pumpWidget(host(WBButton(
        label: 'b',
        autofocus: true,
        focusNode: FocusNode(),
        onLongPress: () => long++,
        onPressed: () {},
      )));
      await t.longPress(find.byType(WBButton));
      expect(long, 1);
    });

    testWidgets('WBCard exposes clipBehavior + constraints', (t) async {
      await t.pumpWidget(host(WBCard(
        clipBehavior: Clip.hardEdge,
        constraints: const BoxConstraints(minHeight: 80),
        child: const Text('c'),
      )));
      expect(find.text('c'), findsOneWidget);
    });
  });
}
