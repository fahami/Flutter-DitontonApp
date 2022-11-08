import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchListTvStatus checkWatchlistStatus;
  final SaveWatchTvlist saveWatchTvlist;
  final RemoveWatchTvlist removeWatchTvlist;
  WatchlistTvBloc({
    required this.checkWatchlistStatus,
    required this.saveWatchTvlist,
    required this.removeWatchTvlist,
  }) : super(WatchlistTvEmpty()) {
    on<AddWatchlistTv>((event, emit) async {
      final tv = event.tv;
      emit(WatchlistTvLoading());
      final result = await saveWatchTvlist.execute(tv);
      result.fold(
        (failure) => emit(WatchlistTvError(failure.message)),
        (data) => emit(WatchlistTvStatus(true)),
      );
    });

    on<DeleteWatchlistTv>((event, emit) {
      final tv = event.tv;
      emit(WatchlistTvLoading());
      removeWatchTvlist.execute(tv).then((result) {
        result.fold(
          (failure) => emit(WatchlistTvError(failure.message)),
          (data) => emit(WatchlistTvStatus(false)),
        );
      });
    });

    on<LoadWatchlistTvStatus>((event, emit) async {
      final result = await checkWatchlistStatus.execute(event.id);
      emit(WatchlistTvStatus(result));
    });
  }
}
