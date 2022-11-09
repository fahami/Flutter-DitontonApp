part of '../tv_recommendation_bloc.dart';

abstract class TvRecommendationState extends Equatable {
  const TvRecommendationState();

  @override
  List<Object> get props => [];
}

class TvRecommendationInitial extends TvRecommendationState {}

class TvRecommendationLoading extends TvRecommendationState {}

class TvRecommendationEmpty extends TvRecommendationState {}

class TvRecommendationHasData extends TvRecommendationState {
  final List<Tv> tvRecommendations;

  TvRecommendationHasData(this.tvRecommendations);

  @override
  List<Object> get props => [tvRecommendations];
}

class TvRecommendationError extends TvRecommendationState {
  final String message;

  TvRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
