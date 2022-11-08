part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailHasData extends TvDetailState {
  final TvDetail tv;

  const TvDetailHasData(this.tv);

  @override
  List<Object> get props => [tv];
}

class TvDetailError extends TvDetailState {
  final String message;

  const TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}
