import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_box/widgets_box.dart';

Widget _host(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  testWidgets('WBFieldLabel shows text and required asterisk', (tester) async {
    await tester.pumpWidget(_host(
      const WBFieldLabel('Email', isRequired: true),
    ));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text(' *'), findsOneWidget);
  });

  testWidgets('WBDropdownField renders options and selects', (tester) async {
    String? picked;
    await tester.pumpWidget(_host(
      SizedBox(
        width: 300,
        child: WBDropdownField<String>(
          title: 'Type',
          options: const ['A', 'B'],
          onChanged: (v) => picked = v,
        ),
      ),
    ));
    expect(find.text('Type'), findsOneWidget);
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('B').last);
    await tester.pumpAndSettle();
    expect(picked, 'B');
  });

  testWidgets('WBDateField shows the formatted value', (tester) async {
    await tester.pumpWidget(_host(
      SizedBox(
        width: 300,
        child: WBDateField(title: 'Date', value: DateTime(2026, 8, 5)),
      ),
    ));
    expect(find.text('Date'), findsOneWidget);
    expect(find.text('05/08/2026'), findsOneWidget);
  });

  testWidgets('WBPinField fills cells and fires onCompleted', (tester) async {
    String? completed;
    await tester.pumpWidget(_host(
      WBPinField(length: 4, onCompleted: (v) => completed = v),
    ));
    await tester.enterText(find.byType(TextField), '1234');
    await tester.pump();
    expect(completed, '1234');
    // Digits render in the visible cells.
    expect(find.text('1'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
  });
}
