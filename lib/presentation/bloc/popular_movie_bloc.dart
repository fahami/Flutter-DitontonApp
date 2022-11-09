import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'event/popular_movie_event.dart';
part 'state/popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;
  PopularMovieBloc(this.getPopularMovies) : super(PopularMovieEmpty()) {
    on<FetchPopularMovie>((event, emit) async {
      emit(PopularMovieLoading());
      await getPopularMovies.execute().then((result) {
        result.fold(
          (failure) {
            emit(PopularMovieError(failure.message));
          },
          (moviesData) {
            emit(PopularMovieHasData(moviesData));
          },
        );
      });
    });
  }
}
