import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetWatchlistMovie {
  final MovieRepository _repository;

  GetWatchlistMovie(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovie();
  }
}
