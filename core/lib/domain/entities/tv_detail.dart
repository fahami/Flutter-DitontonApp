import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

import 'season.dart';

class TvDetail extends Equatable {
  const TvDetail({
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
    required this.lastAirDate,
    required this.seasons,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final List<String>? originCountry;
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
  final String? lastAirDate;
  final List<Season> seasons;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        seasons,
        id,
        originalName,
        overview,
        popularity,
        posterPath,
        originCountry,
        name,
        originalLanguage,
        voteAverage,
        voteCount,
        firstAirDate,
        lastAirDate
      ];
}
