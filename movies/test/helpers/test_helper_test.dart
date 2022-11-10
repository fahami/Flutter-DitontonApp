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
import 'package:movies/movies.dart';

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

// Now playing movie
class FakeNowPlayingEvent extends Fake implements NowPlayingMovieEvent {}

class FakeNowPlayingState extends Fake implements NowPlayingMovieState {}

class FakeNowPlayingMovieBloc
    extends MockBloc<NowPlayingMovieEvent, NowPlayingMovieState>
    implements NowPlayingMovieBloc {}

// Popular movie
class FakePopularEvent extends Fake implements PopularMovieEvent {}

class FakePopularState extends Fake implements PopularMovieState {}

class FakePopularMovieBloc
    extends MockBloc<PopularMovieEvent, PopularMovieState>
    implements PopularMovieBloc {}

// Top rated movie
class FakeTopRatedEvent extends Fake implements TopRatedMovieEvent {}

class FakeTopRatedState extends Fake implements TopRatedMovieState {}

class FakeTopRatedMovieBloc
    extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}

// Movie detail
class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

class FakeMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

// Movie recommendation

class FakeMovieRecommendationEvent extends Fake
    implements MovieRecommendationEvent {}

class FakeMovieRecommendationState extends Fake
    implements MovieRecommendationState {}

class FakeMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

// Watchlist movie

class FakeWatchlistMovieEvent extends Fake implements WatchlistEvent {}

class FakeWatchlistMovieState extends Fake implements WatchlistState {}

class FakeWatchlistMovieBloc extends MockBloc<WatchlistEvent, WatchlistState>
    implements WatchlistBloc {}
