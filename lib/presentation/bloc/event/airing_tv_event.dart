part of '../airing_tv_bloc.dart';

abstract class AiringTvEvent extends Equatable {
  const AiringTvEvent();

  @override
  List<Object> get props => [];
}

class FetchAiringTv extends AiringTvEvent {}
