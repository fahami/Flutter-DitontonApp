import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_test.dart';

void main() {
  late FakeWatchlistTvBloc watchlistMovieBloc;

  setUp(() {
    watchlistMovieBloc = FakeWatchlistTvBloc();
    registerFallbackValue(FakeWatchlistTvEvent());
    registerFallbackValue(FakeWatchlistTvState());
  });

  tearDown(() {
    watchlistMovieBloc.close();
  });

  Widget _makeTestableWidget({required Widget child}) {
    return BlocProvider<WatchlistTvBloc>(
      create: (_) => watchlistMovieBloc,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Loading progress should exist when movie is loading',
      (WidgetTester tester) async {
    when(() => watchlistMovieBloc.state).thenReturn(WatchlistTvLoading());

    final circularProgress = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(
      child: const WatchlistTvs(),
    ));

    expect(circularProgress, findsOneWidget);
  });

  testWidgets('Error message should exist when movie is error',
      (WidgetTester tester) async {
    when(() => watchlistMovieBloc.state)
        .thenReturn(const WatchlistTvError('Error'));

    final errorMessage = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(
      child: const WatchlistTvs(),
    ));

    expect(errorMessage, findsOneWidget);
  });

  testWidgets('Movie list should exist when movie is loaded',
      (WidgetTester tester) async {
    when(() => watchlistMovieBloc.state)
        .thenReturn(WatchlistTvHasData(testTVList));

    final movieList = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(
      child: const WatchlistTvs(),
    ));

    expect(movieList, findsOneWidget);
  });
}
