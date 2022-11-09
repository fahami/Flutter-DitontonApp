import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'event/movie_recommendation_event.dart';
part 'state/movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations _movieRecommendations;
  MovieRecommendationBloc(this._movieRecommendations)
      : super(MovieRecommendationEmpty()) {
    on<FetchMovieRecommendation>((event, emit) async {
      final movieId = event.movieId;
      emit(MovieRecommendationLoading());
      final result = await _movieRecommendations.execute(movieId);
      result.fold(
        (failure) => emit(MovieRecommendationError(failure.message)),
        (data) => emit(MovieRecommendationHasData(data)),
      );
    });
  }
}
