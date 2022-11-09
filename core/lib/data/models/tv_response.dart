import 'package:equatable/equatable.dart';

import 'tv_model.dart';

class TvResponse extends Equatable {
  const TvResponse({this.results});
  final List<TvModel>? results;

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        results: json["results"] == null
            ? null
            : List<TvModel>.from(
                json["results"].map((x) => TvModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [results];
}
