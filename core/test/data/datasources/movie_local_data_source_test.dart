import 'package:core/core.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_movie_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockMovieDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockMovieDatabaseHelper();
    dataSource =
        MovieLocalDataSourceImpl(movieDatabaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertMovieWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertMovieWatchlist(testMovieTable);
      // assert
      expect(result, 'Added movie to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertMovieWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertMovieWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeMovieWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeMovieWatchlist(testMovieTable);
      // assert
      expect(result, 'Removed movie from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeMovieWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeMovieWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('cache now playing movies', () {
    test('should call database helper to save data', () async {
      when(mockDatabaseHelper.clearMovieCache('now playing'))
          .thenAnswer((_) async => 1);

      await dataSource.cacheNowPlayingMovies([testMovieCache]);

      verify(mockDatabaseHelper.clearMovieCache('now playing'));

      verify(mockDatabaseHelper
          .insertMovieCacheTransaction([testMovieCache], 'now playing'));
    });

    test('should return list of movies from db when data exist', () async {
      when(mockDatabaseHelper.getCacheMovies('now playing'))
          .thenAnswer((_) async => [testMovieCacheMap]);

      final result = await dataSource.getCachedNowPlayingMovies();

      expect(result, [testMovieCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      when(mockDatabaseHelper.getCacheMovies('now playing'))
          .thenAnswer((_) async => []);

      final call = dataSource.getCachedNowPlayingMovies();

      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });
}
