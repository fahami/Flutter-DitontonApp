part of '../movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movieDetail;

  const MovieDetailHasData(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}
