import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/serial.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_serials.dart';
import 'package:search/presentation/bloc/search_serials_bloc.dart';

import 'search_serials_bloc_test.mocks.dart';

@GenerateMocks([SearchSerials])
void main() {
  late SearchSerialsBloc searchSerialsBloc;
  late MockSearchSerials mockSearchSerials;

  setUp(() {
    mockSearchSerials = MockSearchSerials();
    searchSerialsBloc = SearchSerialsBloc(mockSearchSerials);
  });

  test('initial state should be empty', () {
    expect(searchSerialsBloc.state, SearchSerialsEmpty());
  });

  final tSerialModel = Serial(
    backdropPath: "/T2Oi1KTOOVhHygBK99yX4QHZg9.jpg",
    firstAirDate: "2021-02-20",
    genreIds: [10759, 35, 18],
    id: 117376,
    name: "Vincenzo",
    originCountry: ["KR"],
    originalLanguage: "ko",
    originalName: "Vincenzo",
    overview:
        "Vincenzo Cassano is an Italian lawyer and Mafia consigliere who moves back to Korea due to a conflict within his organization. He ends up crossing paths with a sharp-tongued lawyer named Cha-young, and the two join forces in using villainous methods to take down villains who cannot be punished by the law.",
    popularity: 75.579,
    posterPath: "/dvXJgEDQXhL9Ouot2WkBHpQiHGd.jpg",
    voteAverage: 8.9,
    voteCount: 374,
  );
  final tSerialList = <Serial>[tSerialModel];
  const tQuery = 'vincenzo';

  blocTest<SearchSerialsBloc, SearchSerialsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchSerials.execute(tQuery))
          .thenAnswer((_) async => Right(tSerialList));
      return searchSerialsBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchSerialsLoading(),
      SearchSerialsHasData(tSerialList),
    ],
    verify: (bloc) {
      verify(mockSearchSerials.execute(tQuery));
    },
  );

  blocTest<SearchSerialsBloc, SearchSerialsState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchSerials.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchSerialsBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchSerialsLoading(),
      const SearchSerialsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchSerials.execute(tQuery));
    },
  );
}
