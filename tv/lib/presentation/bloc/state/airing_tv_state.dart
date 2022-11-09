part of '../airing_tv_bloc.dart';

abstract class AiringTvState extends Equatable {
  const AiringTvState();

  @override
  List<Object> get props => [];
}

class AiringTvInitial extends AiringTvState {}

class AiringTvLoading extends AiringTvState {}

class AiringTvHasData extends AiringTvState {
  final List<Tv> tvs;

  const AiringTvHasData([this.tvs = const []]);

  @override
  List<Object> get props => [tvs];
}

class AiringTvEmpty extends AiringTvState {}

class AiringTvError extends AiringTvState {
  final String message;

  const AiringTvError(this.message);

  @override
  List<Object> get props => [message];
}
