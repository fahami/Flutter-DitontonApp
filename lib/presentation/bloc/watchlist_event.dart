part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlist extends WatchlistEvent {
  final MovieDetail movieDetail;

  AddWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class DeleteWatchlist extends WatchlistEvent {
  final MovieDetail movieDetail;

  DeleteWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchlistStatus extends WatchlistEvent {
  final int movieId;

  LoadWatchlistStatus(this.movieId);

  @override
  List<Object> get props => [movieId];
}
