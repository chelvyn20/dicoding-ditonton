import 'package:core/data/models/movie_table.dart';
import 'package:core/utils/exception.dart';

import 'db/movie_database_helper.dart';

abstract class MovieLocalDataSource {
  Future<String> insertMovieWatchlist(MovieTable movie);
  Future<String> removeMovieWatchlist(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedNowPlayingMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final MovieDatabaseHelper movieDatabaseHelper;

  MovieLocalDataSourceImpl({required this.movieDatabaseHelper});

  @override
  Future<String> insertMovieWatchlist(MovieTable movie) async {
    try {
      await movieDatabaseHelper.insertMovieWatchlist(movie);
      return 'Added movie to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeMovieWatchlist(MovieTable movie) async {
    try {
      await movieDatabaseHelper.removeMovieWatchlist(movie);
      return 'Removed movie from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await movieDatabaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await movieDatabaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
    await movieDatabaseHelper.clearMovieCache('now playing');
    await movieDatabaseHelper.insertMovieCacheTransaction(
        movies, 'now playing');
  }

  @override
  Future<List<MovieTable>> getCachedNowPlayingMovies() async {
    final result = await movieDatabaseHelper.getCacheMovies('now playing');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
