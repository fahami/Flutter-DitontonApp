import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';

import '../../helpers/test_helper_test.mocks.dart';

void main() {
  late GetPopularTvs usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetPopularTvs(mockTvRpository);
  });

  final tTVs = <Tv>[];

  group('GetPopularMovies Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.getPopularTvs())
            .thenAnswer((_) async => Right(tTVs));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTVs));
      });
    });
  });
}
