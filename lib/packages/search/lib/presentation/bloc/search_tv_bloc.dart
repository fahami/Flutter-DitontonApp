import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_tvs.dart';

part 'event/search_tv_event.dart';
part 'state/search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTvs _searchTvs;
  SearchTvBloc(this._searchTvs) : super(SearchTVEmpty()) {
    on<OnQueryChanged>(((event, emit) async {
      final query = event.query;
      emit(SearchTVLoading());

      final res = await _searchTvs.execute(query);

      res.fold(
        (failure) {
          emit(SearchTVError(failure.message));
        },
        (data) {
          emit(SearchTVHasData(data));
        },
      );
    }), transformer: debounce(const Duration(milliseconds: 500)));
  }
}
