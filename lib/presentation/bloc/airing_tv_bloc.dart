import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvs.dart';
import 'package:equatable/equatable.dart';

part 'event/airing_tv_event.dart';
part 'state/airing_tv_state.dart';

class AiringTvBloc extends Bloc<AiringTvEvent, AiringTvState> {
  final GetAiringTvs getAiringTvs;
  AiringTvBloc(this.getAiringTvs) : super(AiringTvEmpty()) {
    on<AiringTvEvent>((event, emit) async {
      emit(AiringTvLoading());
      final result = await getAiringTvs.execute();
      result.fold(
        (failure) {
          emit(AiringTvError(failure.message));
        },
        (tvsData) {
          emit(AiringTvHasData(tvsData));
        },
      );
    });
  }
}
