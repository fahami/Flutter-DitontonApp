part of '../search_tv_bloc.dart';

abstract class SearchTvState extends Equatable {
  const SearchTvState();

  @override
  List<Object> get props => [];
}

class SearchTvInitial extends SearchTvState {}

class SearchTVEmpty extends SearchTvState {}

class SearchTVError extends SearchTvState {
  final String message;

  const SearchTVError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTVLoading extends SearchTvState {}

class SearchTVHasData extends SearchTvState {
  final List<Tv> tvShows;

  const SearchTVHasData(this.tvShows);

  @override
  List<Object> get props => [tvShows];
}
