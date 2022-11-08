import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListEmpty()) {
    on<FetchNowPlayingMovie>((event, emit) {
      emit(MovieListLoading());
      getNowPlayingMovies.execute().then((result) {
        result.fold(
          (failure) {
            emit(MovieListError(failure.message));
          },
          (moviesData) {
            emit(MovieListHasData(moviesData));
          },
        );
      });
    });

    on<FetchPopularMovie>((event, emit) {
      emit(MovieListLoading());
      getPopularMovies.execute().then((result) {
        result.fold(
          (failure) {
            emit(MovieListError(failure.message));
          },
          (moviesData) {
            emit(MovieListHasData(moviesData));
          },
        );
      });
    });

    on<FetchTopRatedMovie>((event, emit) {
      emit(MovieListLoading());
      getTopRatedMovies.execute().then((result) {
        result.fold(
          (failure) {
            emit(MovieListError(failure.message));
          },
          (moviesData) {
            emit(MovieListHasData(moviesData));
          },
        );
      });
    });
  }
}
