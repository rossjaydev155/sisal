import 'package:bloc/bloc.dart';
import 'package:sisal/domain/repositories/feed_repository.dart';
import 'package:sisal/ui/screen/feed/cubit/feed_cubit/feed_state.dart';

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
