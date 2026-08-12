import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_box/widgets_box.dart';

Widget _host(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('WBStatusBadge', () {
    testWidgets('renders the label', (tester) async {
      await tester.pumpWidget(
        _host(const WBStatusBadge(label: 'Paid', colorValue: 'success')),
      );
      expect(find.text('Paid'), findsOneWidget);
    });

    testWidgets('hideWhenEmpty collapses on an empty label', (tester) async {
      await tester.pumpWidget(
        _host(const WBStatusBadge(label: '   ', hideWhenEmpty: true)),
      );
      expect(find.byType(WBStatus), findsNothing);
    });

    testWidgets('resolves a hex color value without throwing', (tester) async {
      await tester.pumpWidget(
        _host(const WBStatusBadge(label: 'Custom', colorValue: '#2E7D4F')),
      );
      expect(find.text('Custom'), findsOneWidget);
    });
  });

  group('WBListRow', () {
    testWidgets('menu row shows title + subtitle and taps', (tester) async {
      var tapped = 0;
      await tester.pumpWidget(
        _host(
          WBListRow.menu(
            title: 'Profile',
            subtitle: 'Edit your info',
            onTap: () => tapped++,
          ),
        ),
      );
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Edit your info'), findsOneWidget);
      await tester.tap(find.text('Profile'));
      expect(tapped, 1);
    });

    testWidgets('toggle row flips via the switch', (tester) async {
      bool? changedTo;
      await tester.pumpWidget(
        _host(
          WBListRow.toggle(
            title: 'Notifications',
            value: false,
            onChanged: (v) => changedTo = v,
          ),
        ),
      );
      await tester.tap(find.byType(Switch));
      expect(changedTo, true);
    });
  });

  group('WBSectionHeader', () {
    testWidgets('renders title and fires the action', (tester) async {
      var acted = 0;
      await tester.pumpWidget(
        _host(
          WBSectionHeader(
            title: 'Recent',
            actionLabel: 'See all',
            onAction: () => acted++,
          ),
        ),
      );
      expect(find.text('Recent'), findsOneWidget);
      await tester.tap(find.text('See all'));
      expect(acted, 1);
    });
  });

  group('WBDetailRow', () {
    testWidgets('money helper groups thousands and drops .00', (tester) async {
      await tester.pumpWidget(
        _host(WBDetailRow.money(label: 'Total', value: 20000)),
      );
      expect(find.text('20,000'), findsOneWidget);
    });

    testWidgets('money helper keeps real decimals', (tester) async {
      await tester.pumpWidget(
        _host(WBDetailRow.money(label: 'Total', value: 1234.5)),
      );
      expect(find.text('1,234.50'), findsOneWidget);
    });

    testWidgets('renders a value widget when provided', (tester) async {
      await tester.pumpWidget(
        _host(
          const WBDetailRow(
            label: 'Status',
            valueWidget: WBStatusBadge(label: 'Open'),
          ),
        ),
      );
      expect(find.text('Status'), findsOneWidget);
      expect(find.text('Open'), findsOneWidget);
    });
  });

  group('WBEmptyState', () {
    testWidgets('shows a retry button that calls onRetry', (tester) async {
      var retried = 0;
      await tester.pumpWidget(
        _host(
          WBEmptyState(
            title: 'Nothing here',
            onRetry: () => retried++,
          ),
        ),
      );
      expect(find.text('Nothing here'), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      expect(retried, 1);
    });
  });
}
