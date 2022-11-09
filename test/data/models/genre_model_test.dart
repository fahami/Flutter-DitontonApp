import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: "Action");

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tGenreModel.toJson();
      // assert
      expect(result, {"id": 1, "name": "Action"});
    });
  });
}
