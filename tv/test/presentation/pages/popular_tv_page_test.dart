import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_test.dart';

void main() {
  late FakePopularTvBloc popularTvBloc;

  setUp(() {
    popularTvBloc = FakePopularTvBloc();
    registerFallbackValue(FakePopularTvEvent());
    registerFallbackValue(FakePopularTvState());
  });

  tearDown(() {
    popularTvBloc.close();
  });

  Widget _makeTestableWidget({required Widget child}) {
    return BlocProvider<PopularTvBloc>(
      create: (_) => popularTvBloc,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Loading progress should exist when movie is loading',
      (WidgetTester tester) async {
    when(() => popularTvBloc.state).thenReturn(PopularTvLoading());

    final circularProgress = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(
      child: const PopularTvsPage(),
    ));
    await tester.pump();
    expect(circularProgress, findsOneWidget);
  });

  testWidgets('Error message should exist when movie is error',
      (WidgetTester tester) async {
    when(() => popularTvBloc.state).thenReturn(const PopularTvError('Error'));

    final errorMessage = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(
      child: const PopularTvsPage(),
    ));
    await tester.pump();
    expect(errorMessage, findsOneWidget);
  });

  testWidgets('Movie list should exist when movie is loaded',
      (WidgetTester tester) async {
    when(() => popularTvBloc.state).thenReturn(PopularTvHasData(testTVList));

    final movieList = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(
      child: const PopularTvsPage(),
    ));
    await tester.pump();
    expect(movieList, findsOneWidget);
  });
}
