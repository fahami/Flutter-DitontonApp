import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_recommendation_event.dart';
part 'tv_recommendation_state.dart';

class TvRecommendationBloc
    extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final GetTvRecommendations getTvRecommendations;
  TvRecommendationBloc(this.getTvRecommendations)
      : super(TvRecommendationEmpty()) {
    on<FetchTvRecommendation>((event, emit) {
      emit(TvRecommendationLoading());
      getTvRecommendations.execute(event.id).then((result) {
        result.fold(
          (failure) => emit(TvRecommendationError(failure.message)),
          (data) => emit(TvRecommendationHasData(data)),
        );
      });
    });
  }
}
