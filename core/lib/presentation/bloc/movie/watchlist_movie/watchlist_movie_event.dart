part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovie extends WatchlistMovieEvent {
  const FetchWatchlistMovie();

  @override
  List<Object> get props => [];
}
