import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_watchlist_serial.dart';
import 'package:core/presentation/bloc/serial/watchlist_serial/watchlist_serial_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_serial_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistSerial])
void main() {
  late MockGetWatchlistSerial mockGetWatchlistSerial;
  late WatchlistSerialBloc watchlistSerialBloc;

  setUp(() {
    mockGetWatchlistSerial = MockGetWatchlistSerial();
    watchlistSerialBloc = WatchlistSerialBloc(mockGetWatchlistSerial);
  });

  test('initial state should be empty', () {
    expect(watchlistSerialBloc.state, WatchlistSerialEmpty());
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

  blocTest<WatchlistSerialBloc, WatchlistSerialState>(
    'Should emit [Loading, HasData] when topRated-serials data is gotten successfully',
    build: () {
      when(mockGetWatchlistSerial.execute())
          .thenAnswer((_) async => Right(tSerialList));
      return watchlistSerialBloc;
    },
    act: (bloc) => bloc.add(const FetchWatchlistSerial()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistSerialLoading(),
      WatchlistSerialHasData(tSerialList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistSerial.execute());
    },
  );

  blocTest<WatchlistSerialBloc, WatchlistSerialState>(
    'Should emit [Loading, Error] when get topRated-serials data is unsuccessful',
    build: () {
      when(mockGetWatchlistSerial.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistSerialBloc;
    },
    act: (bloc) => bloc.add(const FetchWatchlistSerial()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistSerialLoading(),
      const WatchlistSerialError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistSerial.execute());
    },
  );
}
