import 'dart:convert';

import 'package:core/data/models/serial_model.dart';
import 'package:core/data/models/serial_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tSerialModel = SerialModel(
    backdropPath: '/xAKMj134XHQVNHLC6rWsccLMenG.jpg',
    firstAirDate: '2021-10-12',
    genreIds: [10765, 35, 80],
    id: 90462,
    name: 'Chucky',
    originCountry: ["US"],
    originalLanguage: 'en',
    originalName: 'Chucky',
    overview:
        'After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the towns hypocrisies and secrets. Meanwhile, the arrival of enemies and allies from Chuckys past threatens to expose the truth behind the killings, as well as the demon doll untold origins.',
    popularity: 6157.57,
    posterPath: '/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg',
    voteAverage: 8,
    voteCount: 2111,
  );
  const tSerialResponseModel =
      SerialResponse(serialList: <SerialModel>[tSerialModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/serial_on_the_air.json'));
      // act
      final result = SerialResponse.fromMap(jsonMap);
      // assert
      expect(result, tSerialResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSerialResponseModel.toMap();
      // assert
      final expectedJsonMap = {
        'results': [
          {
            'backdrop_path': '/xAKMj134XHQVNHLC6rWsccLMenG.jpg',
            'first_air_date': '2021-10-12',
            'genre_ids': [10765, 35, 80],
            'id': 90462,
            'name': 'Chucky',
            'origin_country': ["US"],
            'original_language': 'en',
            'original_name': 'Chucky',
            'overview':
                'After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the towns hypocrisies and secrets. Meanwhile, the arrival of enemies and allies from Chuckys past threatens to expose the truth behind the killings, as well as the demon doll untold origins.',
            'popularity': 6157.57,
            'poster_path': '/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg',
            'vote_average': 8,
            'vote_count': 2111
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
