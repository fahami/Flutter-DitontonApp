import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late TopRatedTvsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    notifier = TopRatedTvsNotifier(getTopRatedTvs: mockGetTopRatedTvs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: '2020-11-01',
    originalLanguage: 'id',
    originalName: 'TV Name',
    originCountry: ["ID"],
  );

  final tTvList = <Tv>[tTv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTvs.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchTopRatedTvs();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTvs.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchTopRatedTvs();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTvs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTvs();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
