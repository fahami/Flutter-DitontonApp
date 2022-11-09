part of '../top_rated_movie_bloc.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

class TopRatedMovieInitial extends TopRatedMovieState {}

class TopRatedMovieLoading extends TopRatedMovieState {}

class TopRatedMovieEmpty extends TopRatedMovieState {}

class TopRatedMovieHasData extends TopRatedMovieState {
  final List<Movie> movies;

  TopRatedMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class TopRatedMovieError extends TopRatedMovieState {
  final String message;

  TopRatedMovieError(this.message);

  @override
  List<Object> get props => [message];
}
