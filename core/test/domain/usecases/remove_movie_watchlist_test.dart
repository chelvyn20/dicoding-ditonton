import 'package:core/domain/usecases/remove_movie_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_movie_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveMovieWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveMovieWatchlist(mockMovieRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeMovieWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed movie from watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeMovieWatchlist(testMovieDetail));
    expect(result, const Right('Removed movie from watchlist'));
  });
}
