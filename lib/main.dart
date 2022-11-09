import 'dart:ui';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/bloc/airing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tvs_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'presentation/bloc/search_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<SearchBloc>()),
        BlocProvider(create: (_) => di.locator<SearchTvBloc>()),
        BlocProvider(create: (_) => di.locator<MovieRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TvRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistTvBloc>()),
        BlocProvider(create: (_) => di.locator<TvDetailBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingMovieBloc>()),
        BlocProvider(create: (_) => di.locator<AiringTvBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMovieBloc>()),
        BlocProvider(create: (_) => di.locator<PopularTvBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMovieBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedTvBloc>()),
      ],
      child: MaterialApp(
        title: 'Ditonton Apps',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: HomeMoviePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());

            case HomeTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case PopularTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvsPage());
            case TopRatedTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvsPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
