import 'package:ditonton/data/models/tv_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvTable = TvTable(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvTable.toJson();
      // assert
      expect(result, {
        "id": 1,
        "name": "name",
        "overview": "overview",
        "posterPath": "posterPath",
      });
    });
  });
}
