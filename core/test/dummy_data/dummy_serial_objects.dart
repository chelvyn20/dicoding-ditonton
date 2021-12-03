import 'package:core/data/models/serial_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/entities/serial_detail.dart';

final testSerial = Serial(
  backdropPath: '/T2Oi1KTOOVhHygBK99yX4QHZg9.jpg',
  firstAirDate: '2021-02-20',
  genreIds: [10759, 35, 18],
  id: 117376,
  name: 'Vincenzo',
  originCountry: ['KR'],
  originalLanguage: 'ko',
  originalName: 'Vincenzo',
  overview:
      'Vincenzo Cassano is an Italian lawyer and Mafia consigliere who moves back to Korea due to a conflict within his organization. He ends up crossing paths with a sharp-tongued lawyer named Cha-young, and the two join forces in using villainous methods to take down villains who cannot be punished by the law.',
  popularity: 75.579,
  posterPath: '/dvXJgEDQXhL9Ouot2WkBHpQiHGd.jpg',
  voteAverage: 8.9,
  voteCount: 374,
);

final testSerialList = [testSerial];

const testSerialDetail = SerialDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  numberOfSeasons: 1,
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
);

const testSerialCache = SerialTable(
  id: 117376,
  overview:
      'Vincenzo Cassano is an Italian lawyer and Mafia consigliere who moves back to Korea due to a conflict within his organization. He ends up crossing paths with a sharp-tongued lawyer named Cha-young, and the two join forces in using villainous methods to take down villains who cannot be punished by the law.',
  posterPath: '/dvXJgEDQXhL9Ouot2WkBHpQiHGd.jpg',
  name: 'Vincenzo',
);

final testSerialCacheMap = {
  'id': 117376,
  'overview':
      'Vincenzo Cassano is an Italian lawyer and Mafia consigliere who moves back to Korea due to a conflict within his organization. He ends up crossing paths with a sharp-tongued lawyer named Cha-young, and the two join forces in using villainous methods to take down villains who cannot be punished by the law.',
  'posterPath': '/dvXJgEDQXhL9Ouot2WkBHpQiHGd.jpg',
  'name': 'Vincenzo',
};

final testSerialFromCache = Serial.watchlist(
  id: 117376,
  overview:
      'Vincenzo Cassano is an Italian lawyer and Mafia consigliere who moves back to Korea due to a conflict within his organization. He ends up crossing paths with a sharp-tongued lawyer named Cha-young, and the two join forces in using villainous methods to take down villains who cannot be punished by the law.',
  posterPath: '/dvXJgEDQXhL9Ouot2WkBHpQiHGd.jpg',
  name: 'Vincenzo',
);

final testWatchlistSerial = Serial.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testSerialTable = SerialTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSerialMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
