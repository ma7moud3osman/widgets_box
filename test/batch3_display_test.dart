import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_box/widgets_box.dart';

Widget _host(Widget child, {TextDirection dir = TextDirection.ltr}) =>
    MaterialApp(
      home: Directionality(
        textDirection: dir,
        child: Scaffold(body: Center(child: child)),
      ),
    );

void main() {
  testWidgets('WBIconBox renders the icon and is tappable', (tester) async {
    var taps = 0;
    await tester.pumpWidget(_host(
      WBIconBox(icon: Icons.bolt, onTap: () => taps++),
    ));
    expect(find.byIcon(Icons.bolt), findsOneWidget);
    await tester.tap(find.byType(WBIconBox));
    expect(taps, 1);
  });

  testWidgets('WBArrow flips with text direction', (tester) async {
    await tester.pumpWidget(_host(const WBArrow()));
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);

    await tester.pumpWidget(_host(const WBArrow(), dir: TextDirection.rtl));
    expect(find.byIcon(Icons.chevron_left), findsOneWidget);
  });

  testWidgets('WBDividerText shows the label between two dividers',
      (tester) async {
    await tester.pumpWidget(_host(const WBDividerText.or(text: 'OR')));
    expect(find.text('OR'), findsOneWidget);
    expect(find.byType(Divider), findsNWidgets(2));
  });

  testWidgets('WBRatingBar reports the tapped star', (tester) async {
    double? picked;
    await tester.pumpWidget(_host(
      WBRatingBar(rating: 0, onRatingUpdate: (v) => picked = v),
    ));
    // Tap the 4th star.
    await tester.tap(find.byType(GestureDetector).at(3));
    expect(picked, 4.0);
  });

  testWidgets('WBAmountText shows amount, currency and old price',
      (tester) async {
    await tester.pumpWidget(_host(
      const WBAmountText(amount: 12500, oldPrice: 15000, currency: 'EGP'),
    ));
    expect(find.text('12,500'), findsOneWidget);
    expect(find.text('EGP'), findsOneWidget);
    expect(find.text('15,000'), findsOneWidget);
  });

  testWidgets('WBPageDots renders one dot per page', (tester) async {
    await tester.pumpWidget(_host(
      const WBPageDots(count: 4, currentIndex: 1),
    ));
    expect(find.byType(AnimatedContainer), findsNWidgets(4));
  });

  testWidgets('WBTextLink taps the action portion', (tester) async {
    var taps = 0;
    await tester.pumpWidget(_host(
      WBTextLink(
        text: "Don't have an account?",
        actionText: 'Sign up',
        onTap: () => taps++,
      ),
    ));
    expect(find.text('Sign up'), findsOneWidget);
    await tester.tap(find.text('Sign up'));
    expect(taps, 1);
  });

  testWidgets('WBSocialButton shows label + icon, loading hides them',
      (tester) async {
    await tester.pumpWidget(_host(
      const WBSocialButton(label: 'Continue with Google', icon: Icons.g_mobiledata),
    ));
    expect(find.text('Continue with Google'), findsOneWidget);

    await tester.pumpWidget(_host(
      const WBSocialButton(label: 'x', icon: Icons.g_mobiledata, isLoading: true),
    ));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
