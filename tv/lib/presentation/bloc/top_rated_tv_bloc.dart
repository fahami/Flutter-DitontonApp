import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

part 'event/top_rated_tv_event.dart';
part 'state/top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvs getTopRatedTvs;
  TopRatedTvBloc(this.getTopRatedTvs) : super(TopRatedTvEmpty()) {
    on<FetchTopRatedTv>((event, emit) async {
      emit(TopRatedTvLoading());
      await getTopRatedTvs.execute().then((result) {
        result.fold(
          (failure) {
            emit(TopRatedTvError(failure.message));
          },
          (tvsData) {
            emit(TopRatedTvHasData(tvsData));
          },
        );
      });
    });
  }
}
