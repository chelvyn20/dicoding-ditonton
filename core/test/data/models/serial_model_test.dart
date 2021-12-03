import 'package:core/data/models/serial_model.dart';
import 'package:core/domain/entities/serial.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSerialModel = SerialModel(
    backdropPath: 'BackdropPath',
    firstAirDate: 'First Air Date',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Name',
    originCountry: ['Origin Country'],
    originalLanguage: 'Original Language',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1,
    posterPath: 'Poster Path',
    voteAverage: 1,
    voteCount: 1,
  );

  final tSerial = Serial(
    backdropPath: 'BackdropPath',
    firstAirDate: 'First Air Date',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Name',
    originCountry: ['Origin Country'],
    originalLanguage: 'Original Language',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1,
    posterPath: 'Poster Path',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Serial entity', () async {
    final result = tSerialModel.toEntity();
    expect(result, tSerial);
  });
}
