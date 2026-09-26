import 'package:flutter_test/flutter_test.dart';
import 'package:khaar_app/main.dart';

void main() {
  testWidgets('App renders splash screen initially', (WidgetTester tester) async {
    await tester.pumpWidget(const KhaarApp());
    expect(find.text('KHAAR'), findsOneWidget);
    expect(find.text('SUNNYVALE'), findsOneWidget);
    await tester.pump(const Duration(seconds: 13));
  });
}
