import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListTvStatus,
  SaveWatchTvlist,
  RemoveWatchTvlist,
  GetWatchlistTvs,
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late WatchlistTvBloc watchlistTvBloc;
  late TvRecommendationBloc tvRecommendationBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetTvDetail mockGetTvDetail;
  late MockSaveWatchTvlist mockSaveWatchTvlist;
  late MockRemoveWatchTvlist mockRemoveWatchTvlist;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockSaveWatchTvlist = MockSaveWatchTvlist();
    mockRemoveWatchTvlist = MockRemoveWatchTvlist();
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    mockGetWatchlistTvs = MockGetWatchlistTvs();

    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
    tvRecommendationBloc = TvRecommendationBloc(mockGetTvRecommendations);
    watchlistTvBloc = WatchlistTvBloc(
      getWatchlistTvs: mockGetWatchlistTvs,
      saveWatchTvlist: mockSaveWatchTvlist,
      removeWatchTvlist: mockRemoveWatchTvlist,
      checkWatchlistStatus: mockGetWatchListTvStatus,
    );
  });

  const tId = 1;

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: '2020-11-01',
    originalLanguage: 'id',
    originalName: 'TV Name',
    originCountry: const ["ID"],
  );
  final tTvs = <Tv>[tTv];

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTVDetail));
  }

  void _arrangeRecommendationUsecase() {
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvs));
  }

  group('Get TV Detail', () {
    test("initial state should empty", () {
      expect(tvDetailBloc.state, equals(TvDetailEmpty()));
    });

    blocTest<TvDetailBloc, TvDetailState>(
      'should get data from the usecase',
      build: (() {
        _arrangeUsecase();
        return tvDetailBloc;
      }),
      act: ((bloc) => bloc.add(const FetchTvDetail(tId))),
      verify: ((bloc) {
        _arrangeUsecase();
        verify(mockGetTvDetail.execute(tId));
      }),
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should change state to Loading when usecase is called',
      build: (() {
        _arrangeUsecase();
        return tvDetailBloc;
      }),
      act: ((bloc) => bloc.add(const FetchTvDetail(tId))),
      expect: () => [
        TvDetailLoading(),
        TvDetailHasData(testTVDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should change state to Error when usecase is failed',
      build: (() {
        when(mockGetTvDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvDetailBloc;
      }),
      act: ((bloc) => bloc.add(const FetchTvDetail(tId))),
      expect: () => [
        TvDetailLoading(),
        const TvDetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      },
    );
  });

  group('Get Tv Recommendations', () {
    test('initial state should be empty', () {
      expect(tvRecommendationBloc.state, TvRecommendationEmpty());
    });

    blocTest<TvRecommendationBloc, TvRecommendationState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        _arrangeRecommendationUsecase();
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(const FetchTvRecommendation(tId)),
      expect: () => [
        TvRecommendationLoading(),
        TvRecommendationHasData(tTvs),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<TvRecommendationBloc, TvRecommendationState>(
        'Should emit [Loading, Error] when get recommendation is unsuccessful',
        build: () {
          when(mockGetTvRecommendations.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return tvRecommendationBloc;
        },
        act: (bloc) => bloc.add(const FetchTvRecommendation(tId)),
        expect: () => [
              TvRecommendationLoading(),
              const TvRecommendationError('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetTvRecommendations.execute(tId));
        });
  });

  group('Watchlist', () {
    test('initial state should be empty', () {
      expect(watchlistTvBloc.state, WatchlistTvEmpty());
    });
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit WatchlistStatus when event LoadWatchListStatus successfully',
      build: () {
        when(mockGetWatchListTvStatus.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistTvStatus(tId)),
      wait: Duration.zero,
      expect: () => [
        const WatchlistTvStatus(true),
      ],
      verify: (bloc) => verify(mockGetWatchListTvStatus.execute(tId)),
    );
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit WatchlistStatus when event AddWatchlist successfully',
      build: () {
        when(mockSaveWatchTvlist.execute(testTVDetail))
            .thenAnswer((_) async => const Right("Added to Watchlist"));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistTv(testTVDetail)),
      expect: () => [
        WatchlistTvLoading(),
        const WatchlistTvStatus(true),
      ],
      verify: (bloc) => verify(mockSaveWatchTvlist.execute(testTVDetail)),
    );
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit WatchlistError when event AddWatchlist unsuccessfully',
      build: () {
        when(mockSaveWatchTvlist.execute(testTVDetail)).thenAnswer(
            (_) async => const Left(ServerFailure("Server Failure")));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistTv(testTVDetail)),
      expect: () => [
        WatchlistTvLoading(),
        const WatchlistTvError("Server Failure"),
      ],
      verify: (bloc) => verify(mockSaveWatchTvlist.execute(testTVDetail)),
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit WatchlistStatus when event RemoveWatchlist successfully',
      build: () {
        when(mockRemoveWatchTvlist.execute(testTVDetail))
            .thenAnswer((_) async => const Right("Removed from Watchlist"));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistTv(testTVDetail)),
      expect: () => [
        WatchlistTvLoading(),
        const WatchlistTvStatus(false),
      ],
      verify: (bloc) => verify(mockRemoveWatchTvlist.execute(testTVDetail)),
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit WatchlistError when event RemoveWatchlist unsuccessfully',
      build: () {
        when(mockRemoveWatchTvlist.execute(testTVDetail)).thenAnswer(
            (_) async => const Left(ServerFailure("Server Failure")));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistTv(testTVDetail)),
      expect: () => [
        WatchlistTvLoading(),
        const WatchlistTvError("Server Failure"),
      ],
      verify: (bloc) => verify(mockRemoveWatchTvlist.execute(testTVDetail)),
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit WatchlistStatus when event LoadWatchlist successfully',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Right(tTvs));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTv()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvHasData(tTvs),
      ],
      verify: (bloc) => verify(mockGetWatchlistTvs.execute()),
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit WatchlistError when event LoadWatchlist unsuccessfully',
      build: () {
        when(mockGetWatchlistTvs.execute()).thenAnswer(
            (_) async => const Left(ServerFailure("Server Failure")));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTv()),
      expect: () => [
        WatchlistTvLoading(),
        const WatchlistTvError("Server Failure"),
      ],
      verify: (bloc) => verify(mockGetWatchlistTvs.execute()),
    );
  });
}
