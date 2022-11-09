part of '../watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistTv extends WatchlistTvEvent {
  final TvDetail tv;

  const AddWatchlistTv(this.tv);

  @override
  List<Object> get props => [tv];
}

class DeleteWatchlistTv extends WatchlistTvEvent {
  final TvDetail tv;

  const DeleteWatchlistTv(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadWatchlistTvStatus extends WatchlistTvEvent {
  final int id;

  const LoadWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}

class FetchWatchlistTv extends WatchlistTvEvent {}
