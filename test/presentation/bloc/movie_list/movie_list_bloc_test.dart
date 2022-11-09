import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  late NowPlayingMovieBloc nowPlayingBloc;
  late PopularMovieBloc popularBloc;
  late TopRatedMovieBloc topRatedBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();

    nowPlayingBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
    popularBloc = PopularMovieBloc(mockGetPopularMovies);
    topRatedBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

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
  final tMovieList = <Movie>[tMovie];

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(nowPlayingBloc.state, equals(NowPlayingMovieEmpty()));
    });

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovie()),
      expect: () => [
        NowPlayingMovieLoading(),
        NowPlayingMovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
        'Should emit [Loading, Error] when get recommendation is unsuccessful',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return nowPlayingBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingMovie()),
        expect: () => [
              NowPlayingMovieLoading(),
              NowPlayingMovieError('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });
  });

  group('popular movie', () {
    test('initialState should be Empty', () {
      expect(popularBloc.state, equals(PopularMovieEmpty()));
    });
    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovie()),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMovieBloc, PopularMovieState>(
        'Should emit [Loading, Error] when get recommendation is unsuccessful',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return popularBloc;
        },
        act: (bloc) => bloc.add(FetchPopularMovie()),
        expect: () => [
              PopularMovieLoading(),
              PopularMovieError('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });
  });

  group('top rated movie', () {
    test('initialState should be Empty', () {
      expect(topRatedBloc.state, equals(TopRatedMovieEmpty()));
    });
    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovie()),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
        'Should emit [Loading, Error] when get recommendation is unsuccessful',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return topRatedBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedMovie()),
        expect: () => [
              TopRatedMovieLoading(),
              TopRatedMovieError('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        });
  });
}
