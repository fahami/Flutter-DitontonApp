part of '../popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMovieInitial extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieEmpty extends PopularMovieState {}

class PopularMovieHasData extends PopularMovieState {
  final List<Movie> movies;

  const PopularMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class PopularMovieError extends PopularMovieState {
  final String message;

  const PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}
