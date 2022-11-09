import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

part 'event/watchlist_tv_event.dart';
part 'state/watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchListTvStatus checkWatchlistStatus;
  final GetWatchlistTvs getWatchlistTvs;
  final SaveWatchTvlist saveWatchTvlist;
  final RemoveWatchTvlist removeWatchTvlist;
  WatchlistTvBloc({
    required this.getWatchlistTvs,
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
        (data) => emit(const WatchlistTvStatus(true)),
      );
    });

    on<DeleteWatchlistTv>((event, emit) async {
      final tv = event.tv;
      emit(WatchlistTvLoading());
      await removeWatchTvlist.execute(tv).then((result) {
        result.fold(
          (failure) => emit(WatchlistTvError(failure.message)),
          (data) => emit(const WatchlistTvStatus(false)),
        );
      });
    });

    on<LoadWatchlistTvStatus>((event, emit) async {
      final result = await checkWatchlistStatus.execute(event.id);
      emit(WatchlistTvStatus(result));
    });

    on<FetchWatchlistTv>((event, emit) async => {
          emit(WatchlistTvLoading()),
          await getWatchlistTvs.execute().then((result) {
            result.fold(
              (failure) => emit(WatchlistTvError(failure.message)),
              (data) => emit(WatchlistTvHasData(data)),
            );
          })
        });
  }
}
