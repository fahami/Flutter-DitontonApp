import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonModel = SeasonModel(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tSeasonModel.toJson();
      // assert
      expect(result, {
        "air_date": "airDate",
        "episode_count": 1,
        "id": 1,
        "name": "name",
        "overview": "overview",
        "poster_path": "posterPath",
        "season_number": 1,
      });
    });
  });
  group('toEntity', () {
    test('should return a Entity containing proper data', () async {
      final result = tSeasonModel.toEntity();
      // assert
      expect(
          result,
          Season(
            airDate: 'airDate',
            episodeCount: 1,
            id: 1,
            name: 'name',
            overview: 'overview',
            posterPath: 'posterPath',
            seasonNumber: 1,
          ));
    });
  });
}
