import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_serial_detail.dart';
import 'package:core/domain/usecases/get_serial_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_serial_status.dart';
import 'package:core/domain/usecases/remove_serial_watchlist.dart';
import 'package:core/domain/usecases/save_serial_watchlist.dart';
import 'package:core/presentation/provider/serial_detail_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_serial_objects.dart';
import 'serial_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetSerialDetail,
  GetSerialRecommendations,
  GetWatchListSerialStatus,
  SaveSerialWatchlist,
  RemoveSerialWatchlist,
])
void main() {
  late SerialDetailNotifier provider;
  late MockGetSerialDetail mockGetSerialDetail;
  late MockGetSerialRecommendations mockGetSerialRecommendations;
  late MockGetWatchListSerialStatus mockGetWatchlistStatus;
  late MockSaveSerialWatchlist mockSaveWatchlist;
  late MockRemoveSerialWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSerialDetail = MockGetSerialDetail();
    mockGetSerialRecommendations = MockGetSerialRecommendations();
    mockGetWatchlistStatus = MockGetWatchListSerialStatus();
    mockSaveWatchlist = MockSaveSerialWatchlist();
    mockRemoveWatchlist = MockRemoveSerialWatchlist();
    provider = SerialDetailNotifier(
      getSerialDetail: mockGetSerialDetail,
      getSerialRecommendations: mockGetSerialRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;

  final tSerial = Serial(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    originalLanguage: 'originalLanguage',
    originCountry: ['originalCountry'],
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tSerials = <Serial>[tSerial];

  void _arrangeUsecase() {
    when(mockGetSerialDetail.execute(tId))
        .thenAnswer((_) async => const Right(testSerialDetail));
    when(mockGetSerialRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tSerials));
  }

  group('Get Serial Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSerialDetail(tId);
      // assert
      verify(mockGetSerialDetail.execute(tId));
      verify(mockGetSerialRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchSerialDetail(tId);
      // assert
      expect(provider.serialState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change serial when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSerialDetail(tId);
      // assert
      expect(provider.serialState, RequestState.loaded);
      expect(provider.serial, testSerialDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation serials when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSerialDetail(tId);
      // assert
      expect(provider.serialState, RequestState.loaded);
      expect(provider.serialRecommendations, tSerials);
    });
  });

  group('Get Serial Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSerialDetail(tId);
      // assert
      verify(mockGetSerialRecommendations.execute(tId));
      expect(provider.serialRecommendations, tSerials);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSerialDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.serialRecommendations, tSerials);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetSerialDetail.execute(tId))
          .thenAnswer((_) async => const Right(testSerialDetail));
      when(mockGetSerialRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchSerialDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testSerialDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchlistStatus.execute(testSerialDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSerialDetail);
      // assert
      verify(mockSaveWatchlist.execute(testSerialDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testSerialDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchlistStatus.execute(testSerialDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testSerialDetail);
      // assert
      verify(mockRemoveWatchlist.execute(testSerialDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testSerialDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testSerialDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSerialDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testSerialDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testSerialDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testSerialDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testSerialDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetSerialDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetSerialRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tSerials));
      // act
      await provider.fetchSerialDetail(tId);
      // assert
      expect(provider.serialState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
