part of 'tv_list_bloc.dart';

abstract class TvListEvent extends Equatable {
  const TvListEvent();

  @override
  List<Object> get props => [];
}

class FetchAiringTodayTv extends TvListEvent {}

class FetchPopularTv extends TvListEvent {}

class FetchTopRatedTv extends TvListEvent {}
