import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'event/watchlist_event.dart';
part 'state/watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchListStatus watchListStatus;
  final GetWatchlistMovies getWatchlistMovies;
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlist addWatchlist;
  WatchlistBloc({
    required this.getWatchlistMovies,
    required this.watchListStatus,
    required this.removeWatchlist,
    required this.addWatchlist,
  }) : super(WatchlistEmpty()) {
    on<AddWatchlist>((event, emit) async {
      final movie = event.movieDetail;
      emit(WatchlistLoading());
      final result = await addWatchlist.execute(movie);
      result.fold((l) => emit(WatchlistError(l.message)),
          (r) => emit(WatchlistStatus(true)));
    });

    on<DeleteWatchlist>((event, emit) async {
      final movie = event.movieDetail;
      emit(WatchlistLoading());
      final result = await removeWatchlist.execute(movie);
      result.fold(
        (failure) => emit(WatchlistError(failure.message)),
        (data) => emit(WatchlistStatus(false)),
      );
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final id = event.movieId;
      final result = await watchListStatus.execute(id);
      emit(WatchlistStatus(result));
    });

    on<FetchWatchlist>((event, emit) async {
      emit(WatchlistLoading());
      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(WatchlistError(failure.message)),
        (data) => emit(WatchlistHasData(data)),
      );
    });
  }

  @override
  void onChange(Change<WatchlistState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
