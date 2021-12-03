import 'dart:convert';

import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=62c20507bd01d0795c9ee23ee915cfb0';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = MovieRemoteDataSourceImpl(ioClient: mockIOClient);
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/search_spiderman_movie.json')))
        .movieList;
    const tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_spiderman_movie.json'), 200));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
