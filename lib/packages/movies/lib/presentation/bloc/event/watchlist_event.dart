part of '../watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlist extends WatchlistEvent {
  final MovieDetail movieDetail;

  const AddWatchlist(this.movieDetail);
}

class DeleteWatchlist extends WatchlistEvent {
  final MovieDetail movieDetail;

  const DeleteWatchlist(this.movieDetail);
}

class LoadWatchlistStatus extends WatchlistEvent {
  final int movieId;

  const LoadWatchlistStatus(this.movieId);
}

class FetchWatchlist extends WatchlistEvent {}
