import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_local_data_source.dart';
import 'package:core/data/datasources/tv_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movies/movies.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:tv/tv.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => MovieRecommendationBloc(locator()));
  locator.registerFactory(() => WatchlistBloc(
        getWatchlistMovies: locator(),
        addWatchlist: locator(),
        removeWatchlist: locator(),
        watchListStatus: locator(),
      ));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => WatchlistTvBloc(
        getWatchlistTvs: locator(),
        saveWatchTvlist: locator(),
        removeWatchTvlist: locator(),
        checkWatchlistStatus: locator(),
      ));
  locator.registerFactory(() => TvRecommendationBloc(locator()));
  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => NowPlayingMovieBloc(locator()));
  locator.registerFactory(() => AiringTvBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv
  locator.registerLazySingleton(() => GetAiringTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchTvlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchTvlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  // repository movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  // repository tv
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data sources tv
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
