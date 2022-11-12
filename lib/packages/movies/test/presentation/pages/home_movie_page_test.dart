import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_test.dart';

void main() {
  late FakeNowPlayingMovieBloc nowPlayingMovieBloc;
  late FakeTopRatedMovieBloc topRatedMovieBloc;
  late FakePopularMovieBloc popularMovieBloc;

  setUp(() {
    nowPlayingMovieBloc = FakeNowPlayingMovieBloc();
    registerFallbackValue(FakeNowPlayingEvent());
    registerFallbackValue(FakeNowPlayingState());
    topRatedMovieBloc = FakeTopRatedMovieBloc();
    registerFallbackValue(FakeTopRatedEvent());
    registerFallbackValue(FakeTopRatedState());
    popularMovieBloc = FakePopularMovieBloc();
    registerFallbackValue(FakePopularEvent());
    registerFallbackValue(FakePopularState());
  });

  tearDown(() {
    nowPlayingMovieBloc.close();
    topRatedMovieBloc.close();
    popularMovieBloc.close();
  });

  Widget _makeTestableWidget({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMovieBloc>(
          create: (_) => nowPlayingMovieBloc,
        ),
        BlocProvider<TopRatedMovieBloc>(
          create: (_) => topRatedMovieBloc,
        ),
        BlocProvider<PopularMovieBloc>(
          create: (_) => popularMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Loading progress should exist when movie is loading',
      (WidgetTester tester) async {
    when(() => nowPlayingMovieBloc.state).thenReturn(NowPlayingMovieLoading());
    when(() => topRatedMovieBloc.state).thenReturn(TopRatedMovieLoading());
    when(() => popularMovieBloc.state).thenReturn(PopularMovieLoading());

    final circularProgress = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(
      child: const HomeMoviePage(),
    ));
    await tester.pump();
    expect(circularProgress, findsNWidgets(3));
  });

  testWidgets('Error message should exist when movie is error',
      (WidgetTester tester) async {
    when(() => nowPlayingMovieBloc.state)
        .thenReturn(const NowPlayingMovieError('Error'));
    when(() => topRatedMovieBloc.state)
        .thenReturn(const TopRatedMovieError('Error'));
    when(() => popularMovieBloc.state)
        .thenReturn(const PopularMovieError('Error'));

    final errorMessage = find.text('Error');
    await tester.pumpWidget(_makeTestableWidget(
      child: const HomeMoviePage(),
    ));
    await tester.pump();
    expect(errorMessage, findsNWidgets(3));
  });

  testWidgets('Movie list should exist when movie is loaded',
      (WidgetTester tester) async {
    when(() => nowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieHasData(testMovieList));
    when(() => topRatedMovieBloc.state)
        .thenReturn(TopRatedMovieHasData(testMovieList));
    when(() => popularMovieBloc.state)
        .thenReturn(PopularMovieHasData(testMovieList));

    final movieList = find.byType(MovieList);
    await tester.pumpWidget(_makeTestableWidget(
      child: const HomeMoviePage(),
    ));
    await tester.pump();
    expect(movieList, findsNWidgets(3));
  });
}
