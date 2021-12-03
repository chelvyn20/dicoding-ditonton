import 'dart:convert';

import 'package:core/data/datasources/serial_remote_data_source.dart';
import 'package:core/data/models/serial_detail_model.dart';
import 'package:core/data/models/serial_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=62c20507bd01d0795c9ee23ee915cfb0';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late SerialRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = SerialRemoteDataSourceImpl(ioClient: mockIOClient);
  });

  group('get On The air Serials', () {
    final tSerialList = SerialResponse.fromMap(
            json.decode(readJson('dummy_data/serial_on_the_air.json')))
        .serialList;

    test('should return list of Serial Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/serial_on_the_air.json'), 200));
      // act
      final result = await dataSource.getOnTheAirSerials();
      // assert
      expect(result, equals(tSerialList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirSerials();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Serials', () {
    final tSerialList = SerialResponse.fromMap(
            json.decode(readJson('dummy_data/serial_popular.json')))
        .serialList;

    test('should return list of serials when response is success (200)',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/serial_popular.json'), 200));
      // act
      final result = await dataSource.getPopularSerials();
      // assert
      expect(result, tSerialList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularSerials();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Serials', () {
    final tSerialList = SerialResponse.fromMap(
            json.decode(readJson('dummy_data/serial_top_rated.json')))
        .serialList;

    test('should return list of serials when response code is 200 ', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/serial_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedSerials();
      // assert
      expect(result, tSerialList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedSerials();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get serial detail', () {
    const tId = 1;
    final tSerialDetail = SerialDetailModel.fromMap(
        json.decode(readJson('dummy_data/serial_detail.json')));

    test('should return serial detail when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/serial_detail.json'), 200));
      // act
      final result = await dataSource.getSerialDetail(tId);
      // assert
      expect(result, equals(tSerialDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSerialDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get serial recommendations', () {
    final tSerialList = SerialResponse.fromMap(
            json.decode(readJson('dummy_data/serial_recommendations.json')))
        .serialList;
    const tId = 1;

    test('should return list of Serial Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/serial_recommendations.json'), 200));
      // act
      final result = await dataSource.getSerialRecommendations(tId);
      // assert
      expect(result, equals(tSerialList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSerialRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
