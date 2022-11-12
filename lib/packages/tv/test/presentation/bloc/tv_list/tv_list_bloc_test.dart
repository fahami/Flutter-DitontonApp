import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetAiringTvs,
  GetPopularTvs,
  GetTopRatedTvs,
])
void main() {
  late MockGetAiringTvs mockGetAiringTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  late AiringTvBloc airingBloc;
  late PopularTvBloc popularBloc;
  late TopRatedTvBloc topRatedBloc;

  setUp(() {
    mockGetAiringTvs = MockGetAiringTvs();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();

    airingBloc = AiringTvBloc(mockGetAiringTvs);
    popularBloc = PopularTvBloc(mockGetPopularTvs);
    topRatedBloc = TopRatedTvBloc(mockGetTopRatedTvs);
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    originCountry: [],
    originalName: '',
    firstAirDate: '',
    name: '',
    originalLanguage: '',
  );
  final tTvList = <Tv>[tTv];

  group('now airing tv', () {
    test('initialState should be Empty', () {
      expect(airingBloc.state, equals(AiringTvEmpty()));
    });

    blocTest<AiringTvBloc, AiringTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetAiringTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return airingBloc;
      },
      act: (bloc) => bloc.add(FetchAiringTv()),
      expect: () => [
        AiringTvLoading(),
        AiringTvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetAiringTvs.execute());
      },
    );

    blocTest<AiringTvBloc, AiringTvState>(
        'Should emit [Loading, Error] when get recommendation is unsuccessful',
        build: () {
          when(mockGetAiringTvs.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return airingBloc;
        },
        act: (bloc) => bloc.add(FetchAiringTv()),
        expect: () => [
              AiringTvLoading(),
              AiringTvError('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetAiringTvs.execute());
        });
  });

  group('popular tv', () {
    test('initialState should be Empty', () {
      expect(popularBloc.state, equals(PopularTvEmpty()));
    });
    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTv()),
      expect: () => [
        PopularTvLoading(),
        PopularTvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvs.execute());
      },
    );

    blocTest<PopularTvBloc, PopularTvState>(
        'Should emit [Loading, Error] when get recommendation is unsuccessful',
        build: () {
          when(mockGetPopularTvs.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return popularBloc;
        },
        act: (bloc) => bloc.add(FetchPopularTv()),
        expect: () => [
              PopularTvLoading(),
              PopularTvError('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetPopularTvs.execute());
        });
  });

  group('top rated tv', () {
    test('initialState should be Empty', () {
      expect(topRatedBloc.state, equals(TopRatedTvEmpty()));
    });
    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTv()),
      expect: () => [
        TopRatedTvLoading(),
        TopRatedTvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvs.execute());
      },
    );

    blocTest<TopRatedTvBloc, TopRatedTvState>(
        'Should emit [Loading, Error] when get recommendation is unsuccessful',
        build: () {
          when(mockGetTopRatedTvs.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return topRatedBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedTv()),
        expect: () => [
              TopRatedTvLoading(),
              TopRatedTvError('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetTopRatedTvs.execute());
        });
  });
}
