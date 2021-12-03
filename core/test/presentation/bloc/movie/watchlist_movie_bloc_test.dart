import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_watchlist_movie.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovie])
void main() {
  late MockGetWatchlistMovie mockGetWatchlistMovie;
  late WatchlistMovieBloc watchlistMovieBloc;

  setUp(() {
    mockGetWatchlistMovie = MockGetWatchlistMovie();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovie);
  });

  test('initial state should be empty', () {
    expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, HasData] when topRated-movies data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovie.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(const FetchWatchlistMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Error] when get topRated-movies data is unsuccessful',
    build: () {
      when(mockGetWatchlistMovie.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(const FetchWatchlistMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistMovieLoading(),
      const WatchlistMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );
}
