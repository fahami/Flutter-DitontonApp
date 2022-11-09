import 'package:core/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

part 'event/tv_detail_event.dart';
part 'state/tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;

  TvDetailBloc(this.getTvDetail) : super(TvDetailEmpty()) {
    on<FetchTvDetail>((event, emit) async {
      final tvId = event.id;
      emit(TvDetailLoading());
      await getTvDetail.execute(tvId).then((result) {
        result.fold(
          (failure) => emit(TvDetailError(failure.message)),
          (data) => emit(TvDetailHasData(data)),
        );
      });
    });
  }
}
