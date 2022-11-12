import 'package:bloc_test/bloc_test.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_local_data_source.dart';
import 'package:core/data/datasources/tv_remote_data_source.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

// Movie search

class FakeMovieSearchEvent extends Fake implements SearchEvent {}

class FakeMovieSearchState extends Fake implements SearchState {}

class FakeMovieSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

// TV search

class FakeTvSearchEvent extends Fake implements SearchTvEvent {}

class FakeTvSearchState extends Fake implements SearchTvState {}

class FakeTvSearchBloc extends MockBloc<SearchTvEvent, SearchTvState>
    implements SearchTvBloc {}
