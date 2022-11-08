import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchTvlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveWatchTvlist(mockTvRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlist(testTVDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTvRepository.saveWatchlist(testTVDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
