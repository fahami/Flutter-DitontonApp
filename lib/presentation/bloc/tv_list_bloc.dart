import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvs.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:equatable/equatable.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetAiringTvs getAiringTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;
  TvListBloc({
    required this.getAiringTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  }) : super(TvListEmpty()) {
    on<FetchAiringTodayTv>((event, emit) {
      emit(TvListLoading());
      getAiringTvs.execute().then((result) {
        result.fold(
          (failure) {
            emit(TvListError(failure.message));
          },
          (tvsData) {
            emit(TvListHasData(tvsData));
          },
        );
      });
    });
    on<FetchPopularTv>((event, emit) {
      emit(TvListLoading());
      getPopularTvs.execute().then((result) {
        result.fold(
          (failure) {
            emit(TvListError(failure.message));
          },
          (tvsData) {
            emit(TvListHasData(tvsData));
          },
        );
      });
    });
    on<FetchTopRatedTv>((event, emit) {
      emit(TvListLoading());
      getTopRatedTvs.execute().then((result) {
        result.fold(
          (failure) {
            emit(TvListError(failure.message));
          },
          (tvsData) {
            emit(TvListHasData(tvsData));
          },
        );
      });
    });
  }
}
