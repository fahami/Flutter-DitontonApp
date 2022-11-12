import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_test.dart';

void main() {
  late FakeTopRatedTvBloc topRatedTvBloc;

  setUp(() {
    topRatedTvBloc = FakeTopRatedTvBloc();
    registerFallbackValue(FakeTopRatedTvEvent());
    registerFallbackValue(FakeTopRatedTvState());
  });

  tearDown(() {
    topRatedTvBloc.close();
  });

  Widget _makeTestableWidget({required Widget child}) {
    return BlocProvider<TopRatedTvBloc>(
      create: (_) => topRatedTvBloc,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Loading progress should exist when movie is loading',
      (WidgetTester tester) async {
    when(() => topRatedTvBloc.state).thenReturn(TopRatedTvLoading());

    final circularProgress = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(
      child: const TopRatedTvsPage(),
    ));
    await tester.pump();
    expect(circularProgress, findsOneWidget);
  });

  testWidgets('Error message should exist when movie is error',
      (WidgetTester tester) async {
    when(() => topRatedTvBloc.state).thenReturn(const TopRatedTvError('Error'));

    final errorMessage = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(
      child: const TopRatedTvsPage(),
    ));
    await tester.pump();
    expect(errorMessage, findsOneWidget);
  });

  testWidgets('Movie list should exist when movie is loaded',
      (WidgetTester tester) async {
    when(() => topRatedTvBloc.state).thenReturn(TopRatedTvHasData(testTVList));

    final movieList = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(
      child: const TopRatedTvsPage(),
    ));
    await tester.pump();
    expect(movieList, findsOneWidget);
  });
}
