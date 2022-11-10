import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_test.dart';

void main() {
  late FakeWatchlistMovieBloc watchlistMovieBloc;

  setUp(() {
    watchlistMovieBloc = FakeWatchlistMovieBloc();
    registerFallbackValue(FakeWatchlistMovieEvent());
    registerFallbackValue(FakeWatchlistMovieState());
  });

  tearDown(() {
    watchlistMovieBloc.close();
  });

  Widget _makeTestableWidget({required Widget child}) {
    return BlocProvider<WatchlistBloc>(
      create: (_) => watchlistMovieBloc,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Loading progress should exist when movie is loading',
      (WidgetTester tester) async {
    when(() => watchlistMovieBloc.state).thenReturn(WatchlistLoading());

    final circularProgress = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(
      child: const WatchlistMovies(),
    ));

    expect(circularProgress, findsOneWidget);
  });

  testWidgets('Error message should exist when movie is error',
      (WidgetTester tester) async {
    when(() => watchlistMovieBloc.state)
        .thenReturn(const WatchlistError('Error'));

    final errorMessage = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(
      child: const WatchlistMovies(),
    ));

    expect(errorMessage, findsOneWidget);
  });

  testWidgets('Movie list should exist when movie is loaded',
      (WidgetTester tester) async {
    when(() => watchlistMovieBloc.state)
        .thenReturn(WatchlistHasData(testMovieList));

    final movieList = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(
      child: const WatchlistMovies(),
    ));

    expect(movieList, findsOneWidget);
  });
}
