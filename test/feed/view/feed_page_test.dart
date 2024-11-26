// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sisal/domain/models/rss_item.dart';
import 'package:sisal/ui/screen/feed/cubit/feed_cubit.dart';
import 'package:sisal/ui/screen/feed/cubit/feed_cubit/feed_state.dart';
import 'package:sisal/ui/screen/feed/view/feed_page.dart';
import 'package:sisal/ui/widgets/webview_screen.dart';

class MockFeedCubit extends MockCubit<FeedState> implements FeedCubit {}

void main() {
  group('FeedScreen', () {
    late MockFeedCubit feedCubit;

    setUp(() {
      feedCubit = MockFeedCubit();
    });

    testWidgets('renders loading indicator when state is FeedLoading',
        (WidgetTester tester) async {
      when(() => feedCubit.state).thenReturn(FeedLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: feedCubit,
            child: const FeedPage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders feed items when state is FeedLoaded',
        (WidgetTester tester) async {
      final mockItems = [
        RssItem(
          thumbnail: 'https://via.placeholder.com/50',
          title: 'Test Title 1',
          description: 'Test Description 1',
          link: 'https://example.com/1',
        ),
        RssItem(
          thumbnail: 'https://via.placeholder.com/50',
          title: 'Test Title 2',
          description: 'Test Description 2',
          link: 'https://example.com/2',
        ),
      ];

      when(() => feedCubit.state).thenReturn(FeedLoaded(mockItems.cast<RssItem>()));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: feedCubit,
            child: const FeedPage(),
          ),
        ),
      );

      expect(find.byType(ListTile), findsNWidgets(mockItems.length));
      expect(find.text('Test Title 1'), findsOneWidget);
      expect(find.text('Test Description 1'), findsOneWidget);
      expect(find.text('Test Title 2'), findsOneWidget);
      expect(find.text('Test Description 2'), findsOneWidget);
    });

    testWidgets('renders error message when state is FeedError',
        (WidgetTester tester) async {
      const errorMessage = 'Something went wrong';

      when(() => feedCubit.state).thenReturn(FeedError(errorMessage));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: feedCubit,
            child: const FeedPage(),
          ),
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('navigates to WebViewScreen on item tap',
        (WidgetTester tester) async {
      final mockItems = [
         RssItem(
          thumbnail: 'https://via.placeholder.com/50',
          title: 'Test Title 1',
          description: 'Test Description 1',
          link: 'https://example.com/1',
        ),
      ];

      when(() => feedCubit.state).thenReturn(FeedLoaded(mockItems.cast<RssItem>()));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: feedCubit,
            child: const FeedPage(),
          ),
        ),
      );

      await tester.tap(find.text('Test Title 1'));
      await tester.pumpAndSettle();

      expect(find.byType(WebViewScreen), findsOneWidget);
    });
  });
}
