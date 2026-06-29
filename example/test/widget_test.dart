import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('Lurp Widget Demo smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our home screen loads successfully.
    expect(find.text('Lurp Widget Demo'), findsOneWidget);
  });
}
