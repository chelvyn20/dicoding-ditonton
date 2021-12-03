import 'dart:io';

import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/serial_detail_model.dart';
import 'package:core/data/models/serial_model.dart';
import 'package:core/data/repositories/serial_repository_impl.dart';
import 'package:core/domain/entities/serial.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_serial_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SerialRepositoryImpl repository;
  late MockSerialRemoteDataSource mockSerialRemoteDataSource;
  late MockSerialLocalDataSource mockSerialLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockSerialRemoteDataSource = MockSerialRemoteDataSource();
    mockSerialLocalDataSource = MockSerialLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SerialRepositoryImpl(
      serialRemoteDataSource: mockSerialRemoteDataSource,
      serialLocalDataSource: mockSerialLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tSerialModel = SerialModel(
    backdropPath: '/T2Oi1KTOOVhHygBK99yX4QHZg9.jpg',
    firstAirDate: '2021-02-20',
    genreIds: [10759, 35, 18],
    id: 117376,
    name: 'Vincenzo',
    originCountry: ['KR'],
    originalLanguage: 'ko',
    originalName: '빈센조',
    overview:
        'Vincenzo Cassano is an Italian lawyer and Mafia consigliere who moves back to Korea due to a conflict within his organization. He ends up crossing paths with a sharp-tongued lawyer named Cha-young, and the two join forces in using villainous methods to take down villains who cannot be punished by the law.',
    popularity: 75.579,
    posterPath: '/dvXJgEDQXhL9Ouot2WkBHpQiHGd.jpg',
    voteAverage: 8.9,
    voteCount: 374,
  );

  final tSerial = Serial(
    backdropPath: '/T2Oi1KTOOVhHygBK99yX4QHZg9.jpg',
    firstAirDate: '2021-02-20',
    genreIds: [10759, 35, 18],
    id: 117376,
    name: 'Vincenzo',
    originCountry: ['KR'],
    originalLanguage: 'ko',
    originalName: '빈센조',
    overview:
        'Vincenzo Cassano is an Italian lawyer and Mafia consigliere who moves back to Korea due to a conflict within his organization. He ends up crossing paths with a sharp-tongued lawyer named Cha-young, and the two join forces in using villainous methods to take down villains who cannot be punished by the law.',
    popularity: 75.579,
    posterPath: '/dvXJgEDQXhL9Ouot2WkBHpQiHGd.jpg',
    voteAverage: 8.9,
    voteCount: 374,
  );

  final tSerialModelList = <SerialModel>[tSerialModel];
  final tSerialList = <Serial>[tSerial];

  group('On The Air Serials', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockSerialRemoteDataSource.getOnTheAirSerials())
          .thenAnswer((_) async => []);
      // act
      await repository.getOnTheAirSerials();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockSerialRemoteDataSource.getOnTheAirSerials())
            .thenAnswer((_) async => tSerialModelList);

        final result = await repository.getOnTheAirSerials();

        verify(mockSerialRemoteDataSource.getOnTheAirSerials());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tSerialList);
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        when(mockSerialRemoteDataSource.getOnTheAirSerials())
            .thenAnswer((_) async => tSerialModelList);

        await repository.getOnTheAirSerials();

        verify(mockSerialRemoteDataSource.getOnTheAirSerials());
        verify(
            mockSerialLocalDataSource.cacheOnTheAirSerials([testSerialCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockSerialRemoteDataSource.getOnTheAirSerials())
            .thenThrow(ServerException());

        final result = await repository.getOnTheAirSerials();

        verify(mockSerialRemoteDataSource.getOnTheAirSerials());
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        when(mockSerialLocalDataSource.getCachedOnTheAirSerials())
            .thenAnswer((_) async => [testSerialCache]);

        final result = await repository.getOnTheAirSerials();

        verify(mockSerialLocalDataSource.getCachedOnTheAirSerials());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testSerialFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        when(mockSerialLocalDataSource.getCachedOnTheAirSerials())
            .thenThrow(CacheException('No Cache'));

        final result = await repository.getOnTheAirSerials();

        verify(mockSerialLocalDataSource.getCachedOnTheAirSerials());
        expect(result, const Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Popular Serials', () {
    test('should return serial list when call to data source is success',
        () async {
      when(mockSerialRemoteDataSource.getPopularSerials())
          .thenAnswer((_) async => tSerialModelList);

      final result = await repository.getPopularSerials();

      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.getPopularSerials())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularSerials();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.getPopularSerials())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularSerials();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Serials', () {
    test('should return serial list when call to data source is successful',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.getTopRatedSerials())
          .thenAnswer((_) async => tSerialModelList);
      // act
      final result = await repository.getTopRatedSerials();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.getTopRatedSerials())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedSerials();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.getTopRatedSerials())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedSerials();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Serial Detail', () {
    const tId = 1;
    const tSerialResponse = SerialDetailModel(
      backdropPath: 'backdropPath',
      episodeRunTime: [45, 44, 56],
      firstAirDate: 'firstAirDate',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      lastAirDate: 'lastAirDate',
      name: 'name',
      numberOfEpisodes: 3,
      numberOfSeasons: 1,
      originalLanguage: 'en',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'Status',
      tagline: 'Tagline',
      type: 'hero',
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Serial data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.getSerialDetail(tId))
          .thenAnswer((_) async => tSerialResponse);
      // act
      final result = await repository.getSerialDetail(tId);
      // assert
      verify(mockSerialRemoteDataSource.getSerialDetail(tId));
      expect(result, equals(const Right(testSerialDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.getSerialDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSerialDetail(tId);
      // assert
      verify(mockSerialRemoteDataSource.getSerialDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.getSerialDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSerialDetail(tId);
      // assert
      verify(mockSerialRemoteDataSource.getSerialDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Serial Recommendations', () {
    final tSerialList = <SerialModel>[];
    const tId = 1;

    test('should return data (serial list) when the call is successful',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.getSerialRecommendations(tId))
          .thenAnswer((_) async => tSerialList);
      // act
      final result = await repository.getSerialRecommendations(tId);
      // assert
      verify(mockSerialRemoteDataSource.getSerialRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tSerialList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.getSerialRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSerialRecommendations(tId);
      // assertbuild runner
      verify(mockSerialRemoteDataSource.getSerialRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.getSerialRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSerialRecommendations(tId);
      // assert
      verify(mockSerialRemoteDataSource.getSerialRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Serials', () {
    const tQuery = 'spiderman';

    test('should return serial list when call to data source is successful',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.searchSerials(tQuery))
          .thenAnswer((_) async => tSerialModelList);
      // act
      final result = await repository.searchSerials(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.searchSerials(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchSerials(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockSerialRemoteDataSource.searchSerials(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchSerials(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockSerialLocalDataSource.insertSerialWatchlist(testSerialTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveSerialWatchlist(testSerialDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockSerialLocalDataSource.insertSerialWatchlist(testSerialTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveSerialWatchlist(testSerialDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockSerialLocalDataSource.removeSerialWatchlist(testSerialTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeSerialWatchlist(testSerialDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockSerialLocalDataSource.removeSerialWatchlist(testSerialTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeSerialWatchlist(testSerialDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockSerialLocalDataSource.getSerialById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToSerialWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist serials', () {
    test('should return list of Serials', () async {
      // arrange
      when(mockSerialLocalDataSource.getWatchlistSerials())
          .thenAnswer((_) async => [testSerialTable]);
      // act
      final result = await repository.getWatchlistSerial();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistSerial]);
    });
  });
}
