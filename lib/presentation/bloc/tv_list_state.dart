part of 'tv_list_bloc.dart';

abstract class TvListState extends Equatable {
  const TvListState();

  @override
  List<Object> get props => [];
}

class TvListInitial extends TvListState {}

class TvListLoading extends TvListState {}

class TvListEmpty extends TvListState {}

class TvListHasData extends TvListState {
  final List<Tv> tvs;

  TvListHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class TvListError extends TvListState {
  final String message;

  TvListError(this.message);

  @override
  List<Object> get props => [message];
}
