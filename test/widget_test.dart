// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:personal_diet_journal/main.dart';

void main() {
  testWidgets('renders the Personal Diet Journal dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PersonalDietJournalApp());
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Personal Diet Journal'), findsOneWidget);
    expect(find.text('Today\'s Health Score'), findsOneWidget);
    expect(find.text('Nutrition Summary'), findsOneWidget);
  });

  testWidgets('opens the Meals page from bottom navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PersonalDietJournalApp());
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text('Meals').last);
    await tester.pump(const Duration(milliseconds: 100));

    expect(
      find.text('Track what you eat and understand your nutrition.'),
      findsOneWidget,
    );
    expect(find.text("Today's Nutrition"), findsOneWidget);
  });
}
