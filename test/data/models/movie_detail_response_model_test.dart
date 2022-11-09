import 'package:core/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetail = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 1,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    budget: 1,
    revenue: 1,
    status: 'status',
    tagline: 'tagline',
    homepage: '',
    imdbId: '',
    originalLanguage: '',
    popularity: 1,
    video: false,
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tMovieDetail.toJson();
      // assert
      expect(result, {
        "adult": false,
        "backdrop_path": "backdropPath",
        "genres": [],
        "id": 1,
        "original_title": "originalTitle",
        "overview": "overview",
        "poster_path": "posterPath",
        "release_date": "releaseDate",
        "runtime": 1,
        "title": "title",
        "vote_average": 1,
        "vote_count": 1,
        "budget": 1,
        "revenue": 1,
        "status": "status",
        "tagline": "tagline",
        "homepage": "",
        "imdb_id": "",
        "original_language": "",
        "popularity": 1,
        "video": false,
      });
    });
  });
}
