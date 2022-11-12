import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_test.dart';

void main() {
  late FakeTvDetailBloc tvDetailBloc;
  late FakeWatchlistTvBloc watchlistTvBloc;
  late FakeTvRecommendationBloc tvRecommendationBloc;

  setUp(() {
    tvDetailBloc = FakeTvDetailBloc();
    registerFallbackValue(FakeTvDetailEvent());
    registerFallbackValue(FakeTvDetailState());
    tvRecommendationBloc = FakeTvRecommendationBloc();
    registerFallbackValue(FakeTvRecommendationEvent());
    registerFallbackValue(FakeTvRecommendationState());
    watchlistTvBloc = FakeWatchlistTvBloc();
    registerFallbackValue(FakeWatchlistTvEvent());
    registerFallbackValue(FakeWatchlistTvState());
  });

  Widget _makeTestableWidget({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(
          create: (context) => tvDetailBloc,
        ),
        BlocProvider<TvRecommendationBloc>(
          create: (context) => tvRecommendationBloc,
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (context) => watchlistTvBloc,
        ),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  tearDown(() {
    tvDetailBloc.close();
    watchlistTvBloc.close();
  });

  testWidgets('Loading progress should exist when tv is loading',
      (WidgetTester tester) async {
    when(() => tvDetailBloc.state).thenReturn(TvDetailLoading());
    when(() => watchlistTvBloc.state).thenReturn(WatchlistTvLoading());
    when(() => tvRecommendationBloc.state)
        .thenReturn(TvRecommendationLoading());

    final circularProgress = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(
      child: const TvDetailPage(id: 1),
    ));
    await tester.pump();
    expect(circularProgress, findsOneWidget);
  });

  testWidgets("Icon check to watchlist should exist when tv is in watchlist",
      (WidgetTester tester) async {
    when(() => tvDetailBloc.state).thenReturn(TvDetailHasData(testTVDetail));
    when(() => tvRecommendationBloc.state)
        .thenReturn(TvRecommendationHasData(testTVList));
    when(() => watchlistTvBloc.state)
        .thenReturn(WatchlistTvHasData(testTVList));
    when(() => watchlistTvBloc.state).thenReturn(const WatchlistTvStatus(true));

    final addIcon = find.byIcon(Icons.check);
    await tester.pumpWidget(_makeTestableWidget(
      child: const TvDetailPage(id: 1),
    ));
    await tester.pump();
    expect(addIcon, findsOneWidget);
  });

  testWidgets("Show error message when tv not found", ((widgetTester) async {
    when(() => tvDetailBloc.state)
        .thenReturn(const TvDetailError("TV not found"));
    when(() => tvRecommendationBloc.state)
        .thenReturn(const TvRecommendationError("TVs not found"));
    when(() => watchlistTvBloc.state).thenReturn(const WatchlistTvError(""));

    final errorMessage = find.text("TV not found");
    await widgetTester.pumpWidget(_makeTestableWidget(
      child: const TvDetailPage(id: 1),
    ));
    await widgetTester.pump();
    expect(errorMessage, findsOneWidget);
  }));

  testWidgets(
      "Snackbar should appear when remove from watchlist button clicked",
      (tester) async {
    when(() => tvDetailBloc.state).thenReturn(TvDetailHasData(testTVDetail));
    when(() => tvRecommendationBloc.state)
        .thenReturn(TvRecommendationHasData(testTVList));
    when(() => watchlistTvBloc.state)
        .thenReturn(WatchlistTvHasData(testTVList));
    when(() => watchlistTvBloc.state).thenReturn(const WatchlistTvStatus(true));

    final snackBar = find.byType(SnackBar);
    await tester.pumpWidget(_makeTestableWidget(
      child: const TvDetailPage(id: 1),
    ));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.check));
    await tester.pump();
    expect(snackBar, findsOneWidget);
  });
}
