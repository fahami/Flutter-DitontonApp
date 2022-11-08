part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvInitial extends WatchlistTvState {}

class WatchlistTvEmpty extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvStatus extends WatchlistTvState {
  final bool result;

  const WatchlistTvStatus(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistTvError extends WatchlistTvState {
  final String message;

  const WatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}
