import 'package:core/domain/usecases/save_movie_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_movie_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveMovieWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveMovieWatchlist(mockMovieRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveMovieWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Added movie to Watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveMovieWatchlist(testMovieDetail));
    expect(result, const Right('Added movie to Watchlist'));
  });
}
