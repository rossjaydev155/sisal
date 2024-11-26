import 'package:flutter_test/flutter_test.dart';
import 'package:sisal/ui/screen/app/app.dart';
import 'package:sisal/ui/screen/feed/view/feed_page.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(FeedPage), findsOneWidget);
    });
  });
}
