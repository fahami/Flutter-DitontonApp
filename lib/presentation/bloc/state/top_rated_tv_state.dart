part of '../top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

class TopRatedTvInitial extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvHasData extends TopRatedTvState {
  final List<Tv> tvs;

  TopRatedTvHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class TopRatedTvError extends TopRatedTvState {
  final String message;

  TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvEmpty extends TopRatedTvState {}
