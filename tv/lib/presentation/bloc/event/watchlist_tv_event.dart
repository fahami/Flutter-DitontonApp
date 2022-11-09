part of '../watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistTv extends WatchlistTvEvent {
  final TvDetail tv;

  const AddWatchlistTv(this.tv);
}

class DeleteWatchlistTv extends WatchlistTvEvent {
  final TvDetail tv;

  const DeleteWatchlistTv(this.tv);
}

class LoadWatchlistTvStatus extends WatchlistTvEvent {
  final int id;

  const LoadWatchlistTvStatus(this.id);
}

class FetchWatchlistTv extends WatchlistTvEvent {}
