import 'dart:convert';

import 'package:core/domain/entities/serial.dart';
import 'package:equatable/equatable.dart';

class SerialModel extends Equatable {
  final String? backdropPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final num popularity;
  final String? posterPath;
  final num voteAverage;
  final int voteCount;

  const SerialModel({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'backdrop_path': backdropPath,
      'first_air_date': firstAirDate,
      'genre_ids': genreIds,
      'id': id,
      'name': name,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  factory SerialModel.fromMap(Map<String, dynamic> map) {
    return SerialModel(
      backdropPath: map['backdrop_path'],
      firstAirDate: map['first_air_date'],
      genreIds: List<int>.from(map['genre_ids']),
      id: map['id'],
      name: map['name'],
      originCountry: List<String>.from(map['origin_country']),
      originalLanguage: map['original_language'],
      originalName: map['original_name'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SerialModel.fromJson(String source) =>
      SerialModel.fromMap(json.decode(source));

  Serial toEntity() {
    return Serial(
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genreIds: genreIds,
      id: id,
      name: name,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props {
    return [
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
}
