import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_test.dart';

void main() {
  late FakePopularMovieBloc popularMovieBloc;

  setUp(() {
    popularMovieBloc = FakePopularMovieBloc();
    registerFallbackValue(FakePopularEvent());
    registerFallbackValue(FakePopularState());
  });

  tearDown(() {
    popularMovieBloc.close();
  });

  Widget _makeTestableWidget({required Widget child}) {
    return BlocProvider<PopularMovieBloc>(
      create: (_) => popularMovieBloc,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Loading progress should exist when movie is loading',
      (WidgetTester tester) async {
    when(() => popularMovieBloc.state).thenReturn(PopularMovieLoading());

    final circularProgress = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(
      child: const PopularMoviesPage(),
    ));
    await tester.pump();
    expect(circularProgress, findsOneWidget);
  });

  testWidgets('Error message should exist when movie is error',
      (WidgetTester tester) async {
    when(() => popularMovieBloc.state)
        .thenReturn(const PopularMovieError('Error'));

    final errorMessage = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(
      child: const PopularMoviesPage(),
    ));
    await tester.pump();
    expect(errorMessage, findsOneWidget);
  });

  testWidgets('Movie list should exist when movie is loaded',
      (WidgetTester tester) async {
    when(() => popularMovieBloc.state)
        .thenReturn(PopularMovieHasData(testMovieList));

    final movieList = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(
      child: const PopularMoviesPage(),
    ));
    await tester.pump();
    expect(movieList, findsOneWidget);
  });
}
