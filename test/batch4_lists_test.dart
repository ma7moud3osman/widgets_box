import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_box/widgets_box.dart';

Widget _host(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('WBGap renders the right axis size', (tester) async {
    await tester.pumpWidget(_host(
      const Column(children: [WBGap.md(), WBGap.horizontal(20)]),
    ));
    final boxes = tester.widgetList<SizedBox>(find.byType(SizedBox)).toList();
    expect(boxes.any((b) => b.height == 12 && b.width == null), isTrue);
    expect(boxes.any((b) => b.width == 20 && b.height == null), isTrue);
  });

  testWidgets('WBHorizontalList builds items, shows empty text', (tester) async {
    await tester.pumpWidget(_host(
      WBHorizontalList<String>(
        items: const ['a', 'b', 'c'],
        itemBuilder: (_, item, __) => SizedBox(width: 80, child: Text(item)),
      ),
    ));
    expect(find.text('a'), findsOneWidget);
    expect(find.text('c'), findsOneWidget);

    await tester.pumpWidget(_host(
      WBHorizontalList<String>(
        items: const [],
        emptyText: 'Nothing',
        itemBuilder: (_, item, __) => Text(item),
      ),
    ));
    expect(find.text('Nothing'), findsOneWidget);
  });

  testWidgets('WBSliverList renders in a CustomScrollView', (tester) async {
    await tester.pumpWidget(_host(
      CustomScrollView(
        slivers: [
          WBSliverList<int>(
            items: const [1, 2, 3],
            separator: const Divider(),
            itemBuilder: (_, item, __) => ListTile(title: Text('row $item')),
          ),
        ],
      ),
    ));
    expect(find.text('row 1'), findsOneWidget);
    expect(find.text('row 3'), findsOneWidget);
  });

  testWidgets('WBSliverList shows empty state', (tester) async {
    await tester.pumpWidget(_host(
      CustomScrollView(
        slivers: [
          WBSliverList<int>(
            items: const [],
            emptyText: 'No rows',
            itemBuilder: (_, item, __) => Text('$item'),
          ),
        ],
      ),
    ));
    expect(find.text('No rows'), findsOneWidget);
  });
}
