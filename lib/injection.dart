import 'package:core/common/network_info.dart';
import 'package:core/data/datasources/db/movie_database_helper.dart';
import 'package:core/data/datasources/db/serial_database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/serial_local_data_source.dart';
import 'package:core/data/datasources/serial_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/serial_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/serial_repository.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_on_the_air_serials.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_popular_serials.dart';
import 'package:core/domain/usecases/get_serial_detail.dart';
import 'package:core/domain/usecases/get_serial_recommendations.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_top_rated_serials.dart';
import 'package:core/domain/usecases/get_watchlist_movie_status.dart';
import 'package:core/domain/usecases/get_watchlist_movie.dart';
import 'package:core/domain/usecases/get_watchlist_serial_status.dart';
import 'package:core/domain/usecases/get_watchlist_serial.dart';
import 'package:core/domain/usecases/remove_movie_watchlist.dart';
import 'package:core/domain/usecases/remove_serial_watchlist.dart';
import 'package:core/domain/usecases/save_movie_watchlist.dart';
import 'package:core/domain/usecases/save_serial_watchlist.dart';
import 'package:core/presentation/bloc/movie/popular_movies/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/movie/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/serial/popular_serials/popular_serials_bloc.dart';
import 'package:core/presentation/bloc/serial/top_rated_serials/top_rated_serials_bloc.dart';
import 'package:core/presentation/bloc/serial/watchlist_serial/watchlist_serial_bloc.dart';
import 'package:core/presentation/provider/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie_list_notifier.dart';
import 'package:core/presentation/provider/serial_detail_notifier.dart';
import 'package:core/presentation/provider/serial_list_notifier.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton/io_client.dart';
import 'package:http/io_client.dart';
import 'package:get_it/get_it.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_serials.dart';
import 'package:search/presentation/bloc/search_movies_bloc.dart';
import 'package:search/presentation/bloc/search_serials_bloc.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(() => SearchMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(locator()));

  locator.registerFactory(
    () => SerialListNotifier(
      getOnTheAirSerials: locator(),
      getPopularSerials: locator(),
      getTopRatedSerials: locator(),
    ),
  );
  locator.registerFactory(
    () => SerialDetailNotifier(
      getSerialDetail: locator(),
      getSerialRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(() => SearchSerialsBloc(locator()));
  locator.registerFactory(() => PopularSerialsBloc(locator()));
  locator.registerFactory(() => TopRatedSerialsBloc(locator()));
  locator.registerFactory(() => WatchlistSerialBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListMovieStatus(locator()));
  locator.registerLazySingleton(() => SaveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovie(locator()));

  locator.registerLazySingleton(() => GetOnTheAirSerials(locator()));
  locator.registerLazySingleton(() => GetPopularSerials(locator()));
  locator.registerLazySingleton(() => GetTopRatedSerials(locator()));
  locator.registerLazySingleton(() => GetSerialDetail(locator()));
  locator.registerLazySingleton(() => GetSerialRecommendations(locator()));
  locator.registerLazySingleton(() => SearchSerials(locator()));
  locator.registerLazySingleton(() => GetWatchListSerialStatus(locator()));
  locator.registerLazySingleton(() => SaveSerialWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveSerialWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistSerial(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      movieRemoteDataSource: locator(),
      movieLocalDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  locator.registerLazySingleton<SerialRepository>(
    () => SerialRepositoryImpl(
      serialRemoteDataSource: locator(),
      serialLocalDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(movieDatabaseHelper: locator()));

  locator.registerLazySingleton<SerialRemoteDataSource>(
      () => SerialRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<SerialLocalDataSource>(
      () => SerialLocalDataSourceImpl(serialDatabaseHelper: locator()));

  // helper
  locator
      .registerLazySingleton<MovieDatabaseHelper>(() => MovieDatabaseHelper());
  locator.registerLazySingleton<SerialDatabaseHelper>(
      () => SerialDatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
  locator.registerLazySingleton<IOClient>(() => MovieIOClientImpl());

  // external
  locator.registerLazySingleton(() => DataConnectionChecker());
}
