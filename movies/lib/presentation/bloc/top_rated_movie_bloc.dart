import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'event/top_rated_movie_event.dart';
part 'state/top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMovieBloc(this.getTopRatedMovies) : super(TopRatedMovieEmpty()) {
    on<FetchTopRatedMovie>((event, emit) async {
      emit(TopRatedMovieLoading());
      await getTopRatedMovies.execute().then((result) {
        result.fold(
          (failure) {
            emit(TopRatedMovieError(failure.message));
          },
          (moviesData) {
            emit(TopRatedMovieHasData(moviesData));
          },
        );
      });
    });
  }
}
