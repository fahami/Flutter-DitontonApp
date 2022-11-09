import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:ditonton/presentation/bloc/search_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    searchTvBloc = SearchTvBloc(mockSearchTvs);
  });

  test("initial state should empty", () {
    expect(searchTvBloc.state, equals(SearchTVEmpty()));
  });

  final tTvModel = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'spider-man',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: '2020-11-01',
    originalLanguage: 'id',
    originalName: 'TV Name',
    originCountry: ["ID"],
  );
  final tTvList = <Tv>[tTvModel];
  final tQuery = 'spiderman';

  group('search tvs', () {
    blocTest<SearchTvBloc, SearchTvState>(
      'should change state to loading when usecase is called',
      build: () {
        when(mockSearchTvs.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: Duration(milliseconds: 500),
      expect: () => [SearchTVLoading(), SearchTVHasData(tTvList)],
      verify: (bloc) => verify(mockSearchTvs.execute(tQuery)).called(1),
    );

    blocTest<SearchTvBloc, SearchTvState>(
      'should change search result data when data is gotten successfully',
      build: () {
        when(mockSearchTvs.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: Duration(milliseconds: 500),
      expect: () => [SearchTVLoading(), SearchTVHasData(tTvList)],
      verify: (bloc) => verify(mockSearchTvs.execute(tQuery)).called(1),
    );

    blocTest<SearchTvBloc, SearchTvState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockSearchTvs.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: Duration(milliseconds: 500),
      expect: () => [SearchTVLoading(), SearchTVError('Server Failure')],
      verify: (bloc) => verify(mockSearchTvs.execute(tQuery)).called(1),
    );
  });
}
