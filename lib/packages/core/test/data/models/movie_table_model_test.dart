import 'package:core/data/models/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tMovieTable.toJson();
      // assert
      expect(result, {
        "id": 1,
        "title": "title",
        "overview": "overview",
        "posterPath": "posterPath",
      });
    });
  });
}
