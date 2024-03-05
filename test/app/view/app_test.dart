import 'package:flutter_test/flutter_test.dart';
import 'package:onusworks_albums_app/app/app.dart';
import 'package:onusworks_albums_app/src/onboard/onboard.dart';

void main() {
  group('App', () {
    testWidgets('renders OnboardingPage', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(OnboardPage), findsOneWidget);
    });
  });
}
