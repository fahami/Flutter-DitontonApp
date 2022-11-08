import 'package:bloc/bloc.dart';
import 'package:ditonton/common/transformer.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:equatable/equatable.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

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
