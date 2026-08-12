import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_box/widgets_box.dart';

void main() {
  group('WBDates', () {
    test('isSameDay / isToday / startOfDay', () {
      final a = DateTime(2026, 8, 5, 9);
      final b = DateTime(2026, 8, 5, 23);
      expect(WBDates.isSameDay(a, b), isTrue);
      expect(WBDates.isSameDay(a, DateTime(2026, 8, 6)), isFalse);
      expect(WBDates.isToday(DateTime.now()), isTrue);
      expect(WBDates.startOfDay(a), DateTime(2026, 8, 5));
    });

    test('daysFromToday', () {
      final now = DateTime.now();
      expect(WBDates.daysFromToday(now), 0);
      expect(WBDates.daysFromToday(now.add(const Duration(days: 1))), 1);
      expect(WBDates.daysFromToday(now.subtract(const Duration(days: 2))), -2);
    });

    test('format applies the pattern', () {
      expect(WBDates.format(DateTime(2026, 8, 5)), '05/08/2026');
    });
  });

  group('WBSheets', () {
    testWidgets('shows content, title and drag handle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => WBSheets.show(
                  context,
                  title: 'Log out',
                  subtitle: 'Are you sure?',
                  builder: (_) => const Text('sheet-body'),
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.text('Log out'), findsOneWidget);
      expect(find.text('Are you sure?'), findsOneWidget);
      expect(find.text('sheet-body'), findsOneWidget);
    });
  });

  group('WBDialogs', () {
    testWidgets('confirm returns true on confirm (Material)', (tester) async {
      late Future<bool> future;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => future = WBDialogs.confirm(
                  context,
                  title: 'Delete?',
                  message: 'This cannot be undone.',
                  confirmLabel: 'Delete',
                  cancelLabel: 'Cancel',
                  isDestructive: true,
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.text('Delete?'), findsOneWidget);
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(await future, isTrue);
    });

    testWidgets('confirm returns false on cancel', (tester) async {
      late Future<bool> future;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => future = WBDialogs.confirm(
                  context,
                  title: 'Delete?',
                  confirmLabel: 'Yes',
                  cancelLabel: 'No',
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('No'));
      await tester.pumpAndSettle();
      expect(await future, isFalse);
    });
  });
}
