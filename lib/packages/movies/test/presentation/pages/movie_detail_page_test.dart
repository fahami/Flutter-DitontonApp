import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_test.dart';

void main() {
  late FakeMovieDetailBloc mockMovieDetailBloc;
  late FakeMovieRecommendationBloc mockMovieRecommendationBloc;
  late FakeWatchlistMovieBloc mockWatchlistBloc;

  setUp(() {
    mockMovieDetailBloc = FakeMovieDetailBloc();
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    mockMovieRecommendationBloc = FakeMovieRecommendationBloc();
    registerFallbackValue(FakeMovieRecommendationEvent());
    registerFallbackValue(FakeMovieRecommendationState());
    mockWatchlistBloc = FakeWatchlistMovieBloc();
    registerFallbackValue(FakeWatchlistMovieEvent());
    registerFallbackValue(FakeWatchlistMovieState());
  });

  Widget _makeTestableWidget({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (context) => mockMovieRecommendationBloc,
        ),
        BlocProvider<WatchlistBloc>(
          create: (context) => mockWatchlistBloc,
        ),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  tearDown(() {
    mockMovieDetailBloc.close();
    mockMovieRecommendationBloc.close();
    mockWatchlistBloc.close();
  });

  testWidgets('Loading progress should exist when movie is loading',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
    when(() => mockWatchlistBloc.state).thenReturn(WatchlistLoading());
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationLoading());

    final circularProgress = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(
      child: const MovieDetailPage(id: 1),
    ));
    await tester.pump();
    expect(circularProgress, findsOneWidget);
  });

  testWidgets("Icon check to watchlist should exist when movie is in watchlist",
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => mockWatchlistBloc.state)
        .thenReturn(WatchlistHasData(testMovieList));
    when(() => mockWatchlistBloc.state).thenReturn(const WatchlistStatus(true));

    final addIcon = find.byIcon(Icons.check);
    await tester.pumpWidget(_makeTestableWidget(
      child: const MovieDetailPage(id: 1),
    ));
    await tester.pump();
    expect(addIcon, findsOneWidget);
  });

  testWidgets("Show error message when movie not found", ((widgetTester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailError("Movie not found"));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(const MovieRecommendationError("Movie not found"));
    when(() => mockWatchlistBloc.state)
        .thenReturn(const WatchlistError("Movie not found"));

    final errorMessage = find.text("Movie not found");
    await widgetTester.pumpWidget(_makeTestableWidget(
      child: const MovieDetailPage(id: 1),
    ));
    await widgetTester.pump();
    expect(errorMessage, findsOneWidget);
  }));

  testWidgets(
    "Show error message when movie recommendation not found",
    (widgetTester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationBloc.state).thenReturn(
          const MovieRecommendationError("Movie recommendation not found"));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistError("Movie not found"));

      final errorMessage = find.text("Movie recommendation not found");
      await widgetTester.pumpWidget(_makeTestableWidget(
        child: const MovieDetailPage(id: 1),
      ));
      await widgetTester.pump();
      expect(errorMessage, findsOneWidget);
    },
  );

  testWidgets(
      "Snackbar should appear when remove from watchlist button clicked",
      (tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => mockWatchlistBloc.state)
        .thenReturn(WatchlistHasData(testMovieList));
    when(() => mockWatchlistBloc.state).thenReturn(const WatchlistStatus(true));

    final snackBar = find.byType(SnackBar);
    await tester.pumpWidget(_makeTestableWidget(
      child: const MovieDetailPage(id: 1),
    ));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.check));
    await tester.pump();
    expect(snackBar, findsOneWidget);
  });
}
