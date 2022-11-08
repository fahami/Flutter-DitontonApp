import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: "/wvdWb5kTQipdMDqCclC6Y3zr4j3.jpg",
    firstAirDate: "2010-10-31",
    genreIds: [10759, 18, 10765],
    id: 1402,
    name: "The Walking Dead",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The Walking Dead",
    overview:
        "Sheriff's deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.",
    popularity: 975.892,
    posterPath: "/w21lgYIi9GeUH5dO8l3B9ARZbCB.jpg",
    voteAverage: 8.1,
    voteCount: 11794,
  );
  final tTVResponseModel = TvResponse(results: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/wvdWb5kTQipdMDqCclC6Y3zr4j3.jpg",
            "first_air_date": "2010-10-31",
            "genre_ids": [10759, 18, 10765],
            "id": 1402,
            "name": "The Walking Dead",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "The Walking Dead",
            "overview":
                "Sheriff's deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.",
            "popularity": 975.892,
            "poster_path": "/w21lgYIi9GeUH5dO8l3B9ARZbCB.jpg",
            "vote_average": 8.1,
            "vote_count": 11794
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
