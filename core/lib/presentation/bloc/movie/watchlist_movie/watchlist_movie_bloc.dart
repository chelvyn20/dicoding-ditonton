import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_watchlist_movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovie _getWatchlistMovie;

  WatchlistMovieBloc(this._getWatchlistMovie) : super(WatchlistMovieEmpty()) {
    on<FetchWatchlistMovie>(
      (event, emit) async {
        emit(WatchlistMovieLoading());
        final result = await _getWatchlistMovie.execute();

        result.fold(
          (failure) {
            emit(WatchlistMovieError(failure.message));
          },
          (data) {
            emit(WatchlistMovieHasData(data));
          },
        );
      },
    );
  }
}
