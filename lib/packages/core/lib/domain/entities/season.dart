import 'package:equatable/equatable.dart';

class Season extends Equatable {
  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String? airDate;
  final int id;
  final String? overview;
  final String? posterPath;
  final String? name;
  final int? seasonNumber;
  final int? episodeCount;

  @override
  List<Object?> get props => [
        airDate,
        id,
        overview,
        posterPath,
        name,
        seasonNumber,
        episodeCount,
      ];
}
