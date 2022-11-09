import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'event/now_playing_movie_event.dart';
part 'state/now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMovieBloc(this.getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<FetchNowPlayingMovie>((event, emit) async {
      emit(NowPlayingMovieLoading());
      await getNowPlayingMovies.execute().then((result) {
        result.fold(
          (failure) {
            emit(NowPlayingMovieError(failure.message));
          },
          (moviesData) {
            emit(NowPlayingMovieHasData(moviesData));
          },
        );
      });
    });
  }
}
