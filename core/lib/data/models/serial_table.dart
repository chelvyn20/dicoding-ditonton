import 'dart:convert';

import 'package:core/data/models/serial_model.dart';
import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/entities/serial_detail.dart';
import 'package:equatable/equatable.dart';

class SerialTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const SerialTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory SerialTable.fromEntity(SerialDetail serial) => SerialTable(
        id: serial.id,
        name: serial.name,
        posterPath: serial.posterPath,
        overview: serial.overview,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'posterPath': posterPath,
      'overview': overview,
    };
  }

  factory SerialTable.fromMap(Map<String, dynamic> map) {
    return SerialTable(
      id: map['id'],
      name: map['name'],
      posterPath: map['posterPath'],
      overview: map['overview'],
    );
  }

  factory SerialTable.fromDTO(SerialModel serial) => SerialTable(
        id: serial.id,
        name: serial.name,
        posterPath: serial.posterPath,
        overview: serial.overview,
      );

  String toJson() => json.encode(toMap());

  factory SerialTable.fromJson(String source) =>
      SerialTable.fromMap(json.decode(source));

  Serial toEntity() => Serial.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
