import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

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
