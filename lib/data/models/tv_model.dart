import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  TvModel({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    required this.id,
    required this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    required this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genreIds;
  final int id;
  final String name;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String overview;
  final double? popularity;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        firstAirDate:
            json["first_air_date"] == null ? null : json["first_air_date"],
        genreIds: json["genre_ids"] == null
            ? null
            : List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        originCountry: json["origin_country"] == null
            ? null
            : List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"] == null
            ? null
            : json["original_language"],
        originalName:
            json["original_name"] == null ? null : json["original_name"],
        overview: json["overview"] == null ? null : json["overview"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "first_air_date": firstAirDate == null ? null : firstAirDate,
        "genre_ids": genreIds == null
            ? null
            : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage == null ? null : originalLanguage,
        "original_name": originalName == null ? null : originalName,
        "overview": overview == null ? null : overview,
        "popularity": popularity == null ? null : popularity,
        "poster_path": posterPath == null ? null : posterPath,
        "vote_average": voteAverage == null ? null : voteAverage,
        "vote_count": voteCount == null ? null : voteCount,
      };
  Tv toEntity() {
    return Tv(
      backdropPath: this.backdropPath,
      firstAirDate: this.firstAirDate,
      genreIds: this.genreIds,
      id: this.id,
      name: this.name,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
