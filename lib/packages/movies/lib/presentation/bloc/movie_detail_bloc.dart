import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'event/movie_detail_event.dart';
part 'state/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _movieDetail;
  MovieDetailBloc(this._movieDetail) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      final movieId = event.movieId;
      emit(MovieDetailLoading());
      final result = await _movieDetail.execute(movieId);
      result.fold(
        (failure) => emit(MovieDetailError(failure.message)),
        (data) => emit(MovieDetailHasData(data)),
      );
    });
  }
}
