import 'package:bloc/bloc.dart';
import 'package:sisal/cubits/feed_cubit/feed_state.dart';
import 'package:sisal/repositories/feed_repository.dart';

class FeedCubit extends Cubit<FeedState> {

  FeedCubit(this.repository) : super(FeedInitial());
  final FeedRepository repository;

  Future<void> fetchFeed() async {
    emit(FeedLoading());
    try {
      final feedItems = await repository.fetchFeed();
      emit(FeedLoaded(feedItems));
    } catch (e) {
      emit(FeedError('Errore durante il caricamento del feed.'));
    }
  }
}
