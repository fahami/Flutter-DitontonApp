import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late WatchlistBloc watchlistBloc;
  late MovieRecommendationBloc movieRecommendationBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockGetMovieRecommendations = MockGetMovieRecommendations();

    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
    watchlistBloc = WatchlistBloc(
      addWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
      watchListStatus: mockGetWatchListStatus,
    );
    movieRecommendationBloc = MovieRecommendationBloc(
      mockGetMovieRecommendations,
    );
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
  }

  void _arrangeRecommendationUsecase() {
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should get data from the usecase',
      build: (() {
        _arrangeUsecase();
        return movieDetailBloc;
      }),
      act: ((bloc) => bloc.add(FetchMovieDetail(tId))),
      verify: ((bloc) {
        _arrangeUsecase();
        verify(mockGetMovieDetail.execute(tId));
      }),
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should change state to Loading when usecase is called',
      build: (() {
        _arrangeUsecase();
        return movieDetailBloc;
      }),
      act: ((bloc) => bloc.add(FetchMovieDetail(tId))),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailHasData(testMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('Get Movie Recommendations', () {
    test('initial state should be empty', () {
      expect(movieRecommendationBloc.state, MovieRecommendationEmpty());
    });

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        _arrangeRecommendationUsecase();
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(FetchMovieRecommendation(tId)),
      expect: () => [
        MovieRecommendationLoading(),
        MovieRecommendationHasData(tMovies),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
        'Should emit [Loading, Error] when get recommendation is unsuccessful',
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieRecommendationBloc;
        },
        act: (bloc) => bloc.add(FetchMovieRecommendation(tId)),
        expect: () => [
              MovieRecommendationLoading(),
              MovieRecommendationError('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
        });
  });

  group('Watchlist', () {
    test('initial state should be empty', () {
      expect(watchlistBloc.state, WatchlistEmpty());
    });
    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit WatchlistStatus when event LoadWatchListStatus successfully',
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
      wait: Duration.zero,
      expect: () => [
        WatchlistStatus(true),
      ],
      verify: (bloc) => verify(mockGetWatchListStatus.execute(tId)),
    );
    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit WatchlistStatus when event AddWatchlist successfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right("Added to Watchlist"));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistLoading(),
        WatchlistStatus(true),
      ],
      verify: (bloc) => verify(mockSaveWatchlist.execute(testMovieDetail)),
    );
    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit WatchlistError when event AddWatchlist unsuccessfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistLoading(),
        WatchlistError("Server Failure"),
      ],
      verify: (bloc) => verify(mockSaveWatchlist.execute(testMovieDetail)),
    );
  });
}
