import 'package:sisal/domain/models/rss_item.dart';

abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {

  FeedLoaded(this.items);
  final List<RssItem> items;
}

class FeedError extends FeedState {

  FeedError(this.message);
  final String message;
}
