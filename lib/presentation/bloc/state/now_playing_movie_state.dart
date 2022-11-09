part of '../now_playing_movie_bloc.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

class NowPlayingMovieInitial extends NowPlayingMovieState {}

class NowPlayingMovieLoading extends NowPlayingMovieState {}

class NowPlayingMovieEmpty extends NowPlayingMovieState {}

class NowPlayingMovieHasData extends NowPlayingMovieState {
  final List<Movie> movies;

  NowPlayingMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;

  const NowPlayingMovieError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'NowPlayingMovieError { message: $message }';
}
