import 'dart:convert';
import 'package:core/domain/entities/serial_detail.dart';
import 'package:equatable/equatable.dart';

import 'genre_model.dart';

class SerialDetailModel extends Equatable {
  final String? backdropPath;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final num popularity;
  final String posterPath;
  final String status;
  final String tagline;
  final String type;
  final num voteAverage;
  final int voteCount;

  const SerialDetailModel({
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'backdrop_path': backdropPath,
      'episode_run_time': episodeRunTime,
      'first_air_date': firstAirDate,
      'genres': genres.map((x) => x.toMap()).toList(),
      'homepage': homepage,
      'id': id,
      'last_air_date': lastAirDate,
      'name': name,
      'number_of_episodes': numberOfEpisodes,
      'number_of_seasons': numberOfSeasons,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'status': status,
      'tagline': tagline,
      'type': type,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  factory SerialDetailModel.fromMap(Map<String, dynamic> map) {
    return SerialDetailModel(
      backdropPath: map['backdrop_path'],
      episodeRunTime: List<int>.from(map['episode_run_time']),
      firstAirDate: map['first_air_date'],
      genres: List<GenreModel>.from(
          map['genres']?.map((x) => GenreModel.fromMap(x))),
      homepage: map['homepage'],
      id: map['id'],
      lastAirDate: map['last_air_date'],
      name: map['name'],
      numberOfEpisodes: map['number_of_episodes'],
      numberOfSeasons: map['number_of_seasons'],
      originalLanguage: map['original_language'],
      originalName: map['original_name'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'],
      status: map['status'],
      tagline: map['tagline'],
      type: map['type'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SerialDetailModel.fromJson(String source) =>
      SerialDetailModel.fromMap(json.decode(source));

  SerialDetail toEntity() {
    return SerialDetail(
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      firstAirDate: firstAirDate,
      name: name,
      numberOfSeasons: numberOfSeasons,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props {
    return [
      backdropPath,
      episodeRunTime,
      firstAirDate,
      genres,
      homepage,
      id,
      lastAirDate,
      name,
      numberOfEpisodes,
      numberOfSeasons,
      originalLanguage,
      originalName,
      overview,
      popularity,
      posterPath,
      status,
      tagline,
      type,
      voteAverage,
      voteCount,
    ];
  }
}
