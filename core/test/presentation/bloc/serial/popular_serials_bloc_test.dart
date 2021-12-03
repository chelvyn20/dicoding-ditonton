import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_popular_serials.dart';
import 'package:core/presentation/bloc/serial/popular_serials/popular_serials_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_serials_bloc_test.mocks.dart';

@GenerateMocks([GetPopularSerials])
void main() {
  late MockGetPopularSerials mockGetPopularSerials;
  late PopularSerialsBloc popularSerialsBloc;

  setUp(() {
    mockGetPopularSerials = MockGetPopularSerials();
    popularSerialsBloc = PopularSerialsBloc(mockGetPopularSerials);
  });

  test('initial state should be empty', () {
    expect(popularSerialsBloc.state, PopularSerialsEmpty());
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

  blocTest<PopularSerialsBloc, PopularSerialsState>(
    'Should emit [Loading, HasData] when popular-serials data is gotten successfully',
    build: () {
      when(mockGetPopularSerials.execute())
          .thenAnswer((_) async => Right(tSerialList));
      return popularSerialsBloc;
    },
    act: (bloc) => bloc.add(const FetchPopularSerials()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularSerialsLoading(),
      PopularSerialsHasData(tSerialList),
    ],
    verify: (bloc) {
      verify(mockGetPopularSerials.execute());
    },
  );

  blocTest<PopularSerialsBloc, PopularSerialsState>(
    'Should emit [Loading, Error] when get popular-serials data is unsuccessful',
    build: () {
      when(mockGetPopularSerials.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularSerialsBloc;
    },
    act: (bloc) => bloc.add(const FetchPopularSerials()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularSerialsLoading(),
      const PopularSerialsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularSerials.execute());
    },
  );
}
