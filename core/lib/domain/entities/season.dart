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

  String? airDate;
  int id;
  String? overview;
  String? posterPath;
  String? name;
  int? seasonNumber;
  int? episodeCount;

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
