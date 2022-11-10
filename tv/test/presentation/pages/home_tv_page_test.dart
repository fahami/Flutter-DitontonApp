import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_test.dart';

void main() {
  late FakeAiringTvBloc airingTvBloc;
  late FakeTopRatedTvBloc topRatedTvBloc;
  late FakePopularTvBloc popularTvBloc;

  setUp(() {
    airingTvBloc = FakeAiringTvBloc();
    registerFallbackValue(FakeAiringEvent());
    registerFallbackValue(FakeAiringState());
    topRatedTvBloc = FakeTopRatedTvBloc();
    registerFallbackValue(FakeTopRatedTvEvent());
    registerFallbackValue(FakeTopRatedTvState());
    popularTvBloc = FakePopularTvBloc();
    registerFallbackValue(FakePopularTvEvent());
    registerFallbackValue(FakePopularTvState());
  });

  tearDown(() {
    airingTvBloc.close();
    topRatedTvBloc.close();
    popularTvBloc.close();
  });

  Widget _makeTestableWidget({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AiringTvBloc>(
          create: (_) => airingTvBloc,
        ),
        BlocProvider<TopRatedTvBloc>(
          create: (_) => topRatedTvBloc,
        ),
        BlocProvider<PopularTvBloc>(
          create: (_) => popularTvBloc,
        ),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Loading progress should exist when movie is loading',
      (WidgetTester tester) async {
    when(() => airingTvBloc.state).thenReturn(AiringTvLoading());
    when(() => topRatedTvBloc.state).thenReturn(TopRatedTvLoading());
    when(() => popularTvBloc.state).thenReturn(PopularTvLoading());

    final circularProgress = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(
      child: const HomeTvPage(),
    ));
    await tester.pump();
    expect(circularProgress, findsNWidgets(3));
  });

  testWidgets('Error message should exist when movie is error',
      (WidgetTester tester) async {
    when(() => airingTvBloc.state).thenReturn(const AiringTvError('Error'));
    when(() => topRatedTvBloc.state).thenReturn(const TopRatedTvError('Error'));
    when(() => popularTvBloc.state).thenReturn(const PopularTvError('Error'));

    final errorMessage = find.text('Error');
    await tester.pumpWidget(_makeTestableWidget(
      child: const HomeTvPage(),
    ));
    await tester.pump();
    expect(errorMessage, findsNWidgets(3));
  });

  testWidgets('Movie list should exist when movie is loaded',
      (WidgetTester tester) async {
    when(() => airingTvBloc.state).thenReturn(AiringTvHasData(testTVList));
    when(() => topRatedTvBloc.state).thenReturn(TopRatedTvHasData(testTVList));
    when(() => popularTvBloc.state).thenReturn(PopularTvHasData(testTVList));

    final movieList = find.byType(TvList);
    await tester.pumpWidget(_makeTestableWidget(
      child: const HomeTvPage(),
    ));
    await tester.pump();
    expect(movieList, findsNWidgets(3));
  });
}
