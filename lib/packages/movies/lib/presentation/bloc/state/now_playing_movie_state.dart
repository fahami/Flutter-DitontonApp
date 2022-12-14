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

  const NowPlayingMovieHasData(this.movies);
}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;

  const NowPlayingMovieError(this.message);
}
