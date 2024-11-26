// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sisal/domain/models/rss_item.dart';
import 'package:sisal/domain/repositories/feed_repository.dart';
import 'package:sisal/ui/screen/feed/cubit/feed_cubit.dart';
import 'package:sisal/ui/screen/feed/cubit/feed_cubit/feed_state.dart';

class MockFeedRepository extends Mock implements FeedRepository {}

void main() {
  late FeedCubit feedCubit;
  late MockFeedRepository mockFeedRepository;

  setUp(() {
    mockFeedRepository = MockFeedRepository();
    feedCubit = FeedCubit(mockFeedRepository);
  });

  tearDown(() {
    feedCubit.close();
  });

  group('FeedCubit', () {
    test('initial state is FeedInitial', () {
      expect(feedCubit.state, equals(FeedInitial()));
    });

    blocTest<FeedCubit, FeedState>(
      'emits [FeedLoading, FeedLoaded] when fetchFeed succeeds',
      build: () {
        when(() => mockFeedRepository.fetchFeed())
            .thenAnswer((_) async => [
                  // Simula un elenco di feed
                  RssItem(
                    title: 'Title 1',
                    description: 'Description 1',
                    link: 'https://example.com/1',
                    thumbnail: 'https://example.com/image1.png',
                  ),
                  RssItem(
                    title: 'Title 2',
                    description: 'Description 2',
                    link: 'https://example.com/2',
                    thumbnail: 'https://example.com/image2.png',
                  ),
                ],);
        return feedCubit;
      },
      act: (cubit) => cubit.fetchFeed(),
      expect: () => [
        FeedLoading(),
        isA<FeedLoaded>().having(
          (state) => state.items.length,
          'number of items',
          2,
        ),
      ],
      verify: (_) {
        verify(() => mockFeedRepository.fetchFeed()).called(1);
      },
    );

    blocTest<FeedCubit, FeedState>(
      'emits [FeedLoading, FeedError] when fetchFeed fails',
      build: () {
        when(() => mockFeedRepository.fetchFeed())
            .thenThrow(Exception('fetch error'));
        return feedCubit;
      },
      act: (cubit) => cubit.fetchFeed(),
      expect: () => [
        FeedLoading(),
        isA<FeedError>().having(
          (state) => state.message,
          'error message',
          'Errore durante il caricamento del feed.',
        ),
      ],
      verify: (_) {
        verify(() => mockFeedRepository.fetchFeed()).called(1);
      },
    );
  });
}
