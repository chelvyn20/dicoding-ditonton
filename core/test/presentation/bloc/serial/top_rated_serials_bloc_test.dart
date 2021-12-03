import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_top_rated_serials.dart';
import 'package:core/presentation/bloc/serial/top_rated_serials/top_rated_serials_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_serials_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedSerials])
void main() {
  late MockGetTopRatedSerials mockGetTopRatedSerials;
  late TopRatedSerialsBloc topRatedSerialsBloc;

  setUp(() {
    mockGetTopRatedSerials = MockGetTopRatedSerials();
    topRatedSerialsBloc = TopRatedSerialsBloc(mockGetTopRatedSerials);
  });

  test('initial state should be empty', () {
    expect(topRatedSerialsBloc.state, TopRatedSerialsEmpty());
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

  blocTest<TopRatedSerialsBloc, TopRatedSerialsState>(
    'Should emit [Loading, HasData] when topRated-serials data is gotten successfully',
    build: () {
      when(mockGetTopRatedSerials.execute())
          .thenAnswer((_) async => Right(tSerialList));
      return topRatedSerialsBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedSerials()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedSerialsLoading(),
      TopRatedSerialsHasData(tSerialList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSerials.execute());
    },
  );

  blocTest<TopRatedSerialsBloc, TopRatedSerialsState>(
    'Should emit [Loading, Error] when get topRated-serials data is unsuccessful',
    build: () {
      when(mockGetTopRatedSerials.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedSerialsBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedSerials()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedSerialsLoading(),
      const TopRatedSerialsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSerials.execute());
    },
  );
}
