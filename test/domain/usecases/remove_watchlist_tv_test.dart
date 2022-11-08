import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchTvlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchTvlist(mockTvRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlist(testTVDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTvRepository.removeWatchlist(testTVDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
