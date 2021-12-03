import 'package:equatable/equatable.dart';

import 'genre.dart';

class SerialDetail extends Equatable {
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final String name;
  final int numberOfSeasons;
  final num voteAverage;
  final int voteCount;

  const SerialDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.numberOfSeasons,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        firstAirDate,
        name,
        numberOfSeasons,
        voteAverage,
        voteCount,
      ];
}
