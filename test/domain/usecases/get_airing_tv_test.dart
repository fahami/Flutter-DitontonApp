import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_airing_today_tvs.dart';

import '../../helpers/test_helper_test.mocks.dart';

void main() {
  late GetAiringTvs usecase;
  late MockTvRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvRepository();
    usecase = GetAiringTvs(mockMovieRepository);
  });

  final tTvs = <Tv>[];

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getOnTheAirTvs())
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvs));
  });
}
