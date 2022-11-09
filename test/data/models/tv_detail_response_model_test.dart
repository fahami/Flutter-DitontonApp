import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvDetail = TvDetailResponse(
    backdropPath: 'backdropPath',
    episodeRuntime: [1, 2, 3],
    firstAirDate: 'firstAirDate',
    genres: [],
    homepage: 'homepage',
    id: 1,
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    status: 'status',
    tagline: 'tagline',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    lastAirDate: 'lastAirDate',
    seasons: [],
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    type: 'type',
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvDetail.toJson();
      // assert
      expect(result, {
        "backdrop_path": "backdropPath",
        "episode_run_time": [1, 2, 3],
        "first_air_date": "firstAirDate",
        "genres": [],
        "homepage": "homepage",
        "id": 1,
        "origin_country": ["originCountry"],
        "original_language": "originalLanguage",
        "original_name": "originalName",
        "overview": "overview",
        "popularity": 1,
        "poster_path": "posterPath",
        "status": "status",
        "tagline": "tagline",
        "name": "name",
        "vote_average": 1,
        "vote_count": 1,
        "last_air_date": "lastAirDate",
        "seasons": [],
        "number_of_episodes": 1,
        "number_of_seasons": 1,
        "type": "type",
      });
    });
  });
}
