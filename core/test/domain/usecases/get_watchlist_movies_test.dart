import 'package:core/domain/usecases/get_watchlist_movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_movie_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistMovie usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlistMovie(mockMovieRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getWatchlistMovie())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testMovieList));
  });
}
