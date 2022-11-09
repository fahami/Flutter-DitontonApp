import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.originCountry,
    required this.name,
    required this.originalLanguage,
    required this.voteAverage,
    required this.voteCount,
    required this.firstAirDate,
    required this.seasons,
    required this.episodeRuntime,
    required this.lastAirDate,
    required this.homepage,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.type,
    required this.status,
    required this.tagline,
  });

  final String? backdropPath;
  final List<GenreModel> genres;
  final List<String> originCountry;
  final int id;
  final String? originalName;
  final String overview;
  final double? popularity;
  final String? posterPath;
  final String name;
  final String? originalLanguage;
  final double voteAverage;
  final int voteCount;
  final String? firstAirDate;
  final List<SeasonModel> seasons;
  final List<int> episodeRuntime;
  final String? lastAirDate;
  final String? homepage;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final String status;
  final String tagline;
  final String type;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
          backdropPath: json["backdrop_path"],
          genres: List<GenreModel>.from(
              json["genres"].map((x) => GenreModel.fromJson(x))),
          homepage: json["homepage"],
          id: json["id"],
          originalLanguage: json["original_language"],
          overview: json["overview"],
          popularity: json["popularity"].toDouble(),
          posterPath: json["poster_path"],
          status: json["status"],
          tagline: json["tagline"],
          voteAverage: json["vote_average"].toDouble(),
          voteCount: json["vote_count"],
          episodeRuntime:
              List<int>.from(json["episode_run_time"]?.map((x) => x)),
          firstAirDate: json["first_air_date"],
          lastAirDate: json["last_air_date"],
          name: json["name"],
          numberOfEpisodes: json["number_of_episodes"],
          numberOfSeasons: json["number_of_seasons"],
          originalName: json["original_name"],
          originCountry:
              List<String>.from(json["origin_country"].map((x) => x)),
          seasons: List<SeasonModel>.from(
              json["seasons"].map((x) => SeasonModel.fromJson(x))),
          type: json["type"]);

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "original_language": originalLanguage,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "status": status,
        "tagline": tagline,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "episode_run_time": List<dynamic>.from(episodeRuntime.map((x) => x)),
        "first_air_date": firstAirDate,
        "last_air_date": lastAirDate,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "original_name": originalName,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "type": type
      };

  TvDetail toEntity() {
    return TvDetail(
        backdropPath: backdropPath,
        genres: genres.map((genre) => genre.toEntity()).toList(),
        id: id,
        overview: overview,
        posterPath: posterPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
        firstAirDate: firstAirDate,
        lastAirDate: lastAirDate,
        name: name,
        originalLanguage: originalLanguage,
        originalName: originalName,
        originCountry: originCountry,
        popularity: popularity,
        seasons: seasons.map((season) => season.toEntity()).toList());
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        homepage,
        id,
        originalLanguage,
        overview,
        popularity,
        posterPath,
        status,
        tagline,
        voteAverage,
        voteCount,
        firstAirDate,
        lastAirDate,
        seasons,
        originCountry,
        originalName,
        name,
      ];
}
