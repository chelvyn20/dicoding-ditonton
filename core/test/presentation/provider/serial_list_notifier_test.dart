import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_on_the_air_serials.dart';
import 'package:core/domain/usecases/get_popular_serials.dart';
import 'package:core/domain/usecases/get_top_rated_serials.dart';
import 'package:core/presentation/provider/serial_list_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'serial_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetOnTheAirSerials,
  GetPopularSerials,
  GetTopRatedSerials,
])
void main() {
  late SerialListNotifier provider;
  late MockGetOnTheAirSerials mockGetOnTheAirSerials;
  late MockGetPopularSerials mockGetPopularSerials;
  late MockGetTopRatedSerials mockGetTopRatedSerials;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirSerials = MockGetOnTheAirSerials();
    mockGetPopularSerials = MockGetPopularSerials();
    mockGetTopRatedSerials = MockGetTopRatedSerials();
    provider = SerialListNotifier(
      getOnTheAirSerials: mockGetOnTheAirSerials,
      getPopularSerials: mockGetPopularSerials,
      getTopRatedSerials: mockGetTopRatedSerials,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tSerial = Serial(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    originalLanguage: 'originalLanguage',
    originCountry: ['originCountry'],
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tSerialList = <Serial>[tSerial];

  group('on the air serials', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirState, equals(RequestState.empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirSerials.execute())
          .thenAnswer((_) async => Right(tSerialList));
      // act
      provider.fetchOnTheAirSerials();
      // assert
      verify(mockGetOnTheAirSerials.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirSerials.execute())
          .thenAnswer((_) async => Right(tSerialList));
      // act
      provider.fetchOnTheAirSerials();
      // assert
      expect(provider.onTheAirState, RequestState.loading);
    });

    test('should change serials when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirSerials.execute())
          .thenAnswer((_) async => Right(tSerialList));
      // act
      await provider.fetchOnTheAirSerials();
      // assert
      expect(provider.onTheAirState, RequestState.loaded);
      expect(provider.onTheAirSerials, tSerialList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirSerials.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirSerials();
      // assert
      expect(provider.onTheAirState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular serials', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularSerials.execute())
          .thenAnswer((_) async => Right(tSerialList));
      // act
      provider.fetchPopularSerials();
      // assert
      expect(provider.popularSerialsState, RequestState.loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change serials data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularSerials.execute())
          .thenAnswer((_) async => Right(tSerialList));
      // act
      await provider.fetchPopularSerials();
      // assert
      expect(provider.popularSerialsState, RequestState.loaded);
      expect(provider.popularSerials, tSerialList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularSerials.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularSerials();
      // assert
      expect(provider.popularSerialsState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated serials', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedSerials.execute())
          .thenAnswer((_) async => Right(tSerialList));
      // act
      provider.fetchTopRatedSerials();
      // assert
      expect(provider.topRatedSerialsState, RequestState.loading);
    });

    test('should change serials data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedSerials.execute())
          .thenAnswer((_) async => Right(tSerialList));
      // act
      await provider.fetchTopRatedSerials();
      // assert
      expect(provider.topRatedSerialsState, RequestState.loaded);
      expect(provider.topRatedSerials, tSerialList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedSerials.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedSerials();
      // assert
      expect(provider.topRatedSerialsState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
