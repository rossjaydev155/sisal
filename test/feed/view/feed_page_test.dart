// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sisal/domain/models/rss_item.dart';
import 'package:sisal/ui/screen/feed/cubit/feed_cubit.dart';
import 'package:sisal/ui/screen/feed/cubit/feed_cubit/feed_state.dart';
import 'package:sisal/ui/screen/feed/view/feed_page.dart';  // La tua pagina da testare

class MockFeedCubit extends MockCubit<FeedState> implements FeedCubit {}

void main() {
  late MockFeedCubit mockFeedCubit;

  setUp(() {
    mockFeedCubit = MockFeedCubit();
  });

  group('FeedPage', () {
    testWidgets('displays CircularProgressIndicator when loading', (tester) async {
      // Arrange: lo stato iniziale è FeedLoading
      when(() => mockFeedCubit.state).thenReturn(FeedLoading());

      // Act: esegui il widget
      await tester.pumpWidget(
        BlocProvider.value(
          value: mockFeedCubit,
          child: const MaterialApp(home: FeedPage()),
        ),
      );

      // Assert: Verifica che il CircularProgressIndicator sia presente
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays list of items when loaded', (tester) async {
      // Arrange: stato con FeedLoaded
      final mockItems = [
        RssItem(title: 'Item 1', description: 'Description 1', thumbnail: 'url1', link: 'link1'),
        RssItem(title: 'Item 2', description: 'Description 2', thumbnail: 'url2', link: 'link2'),
      ];
      when(() => mockFeedCubit.state).thenReturn(FeedLoaded(mockItems));

      // Act: esegui il widget
      await tester.pumpWidget(
        BlocProvider.value(
          value: mockFeedCubit,
          child: const MaterialApp(home: FeedPage()),
        ),
      );

      // Assert: Verifica che gli elementi siano visibili nella lista
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('displays error message when error occurs', (tester) async {
      // Arrange: stato con FeedError
      when(() => mockFeedCubit.state).thenReturn(FeedError('Errore di caricamento'));

      // Act: esegui il widget
      await tester.pumpWidget(
        BlocProvider.value(
          value: mockFeedCubit,
          child: const MaterialApp(home: FeedPage()),
        ),
      );

      // Assert: Verifica che venga mostrato il messaggio di errore
      expect(find.text('Errore di caricamento'), findsOneWidget);
    });
  });
}
