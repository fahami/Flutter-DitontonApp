import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: '2021-11-01',
    name: 'Name',
    originalLanguage: 'lang',
    originalName: 'name',
    originCountry: ["cd"],
  );

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: '2021-11-01',
    name: 'Name',
    originalLanguage: 'lang',
    originalName: 'name',
    originCountry: ["cd"],
  );

  test('should be a subclass of TV entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
