import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

part 'event/popular_tv_event.dart';
part 'state/popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvs getPopularTvs;
  PopularTvBloc(this.getPopularTvs) : super(PopularTvEmpty()) {
    on<FetchPopularTv>((event, emit) async {
      emit(PopularTvLoading());
      final result = await getPopularTvs.execute();
      result.fold(
        (failure) {
          emit(PopularTvError(failure.message));
        },
        (tvsData) {
          emit(PopularTvHasData(tvsData));
        },
      );
    });
  }
}
