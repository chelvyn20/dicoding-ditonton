import 'package:core/data/datasources/serial_local_data_source.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_serial_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SerialLocalDataSourceImpl dataSource;
  late MockSerialDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockSerialDatabaseHelper();
    dataSource =
        SerialLocalDataSourceImpl(serialDatabaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertSerialWatchlist(testSerialTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertSerialWatchlist(testSerialTable);
      // assert
      expect(result, 'Added serial to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertSerialWatchlist(testSerialTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertSerialWatchlist(testSerialTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeSerialWatchlist(testSerialTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeSerialWatchlist(testSerialTable);
      // assert
      expect(result, 'Removed serial from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeSerialWatchlist(testSerialTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeSerialWatchlist(testSerialTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Serial Detail By Id', () {
    const tId = 1;

    test('should return Serial Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getSerialById(tId))
          .thenAnswer((_) async => testSerialMap);
      // act
      final result = await dataSource.getSerialById(tId);
      // assert
      expect(result, testSerialTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getSerialById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSerialById(tId);
      // assert
      expect(result, null);
    });
  });

  group('cache on the air serials', () {
    test('should call database helper to save data', () async {
      when(mockDatabaseHelper.clearSerialCache('on the air'))
          .thenAnswer((_) async => 1);

      await dataSource.cacheOnTheAirSerials([testSerialCache]);

      verify(mockDatabaseHelper.clearSerialCache('on the air'));

      verify(mockDatabaseHelper
          .insertSerialCacheTransaction([testSerialCache], 'on the air'));
    });

    test('should return list of serials from db when data exist', () async {
      when(mockDatabaseHelper.getCacheSerials('on the air'))
          .thenAnswer((_) async => [testSerialCacheMap]);

      final result = await dataSource.getCachedOnTheAirSerials();

      expect(result, [testSerialCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      when(mockDatabaseHelper.getCacheSerials('on the air'))
          .thenAnswer((_) async => []);

      final call = dataSource.getCachedOnTheAirSerials();

      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('get watchlist serials', () {
    test('should return list of SerialTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistSerials())
          .thenAnswer((_) async => [testSerialMap]);
      // act
      final result = await dataSource.getWatchlistSerials();
      // assert
      expect(result, [testSerialTable]);
    });
  });
}
