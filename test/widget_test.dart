import 'package:flutter_test/flutter_test.dart';
import 'package:computer_rental_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('App should render MainNavigationPage', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    expect(find.text('Computer Rental App'), findsWidgets);
    expect(find.text('Katalog Unit'), findsOneWidget);
  });
}
