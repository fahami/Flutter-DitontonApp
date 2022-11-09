part of '../watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class WatchlistEmpty extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistStatus extends WatchlistState {
  final bool result;

  const WatchlistStatus(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistHasData extends WatchlistState {
  final List<Movie> movies;

  const WatchlistHasData(this.movies);

  @override
  List<Object> get props => [movies];
}
