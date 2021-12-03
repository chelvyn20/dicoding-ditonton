part of 'watchlist_serial_bloc.dart';

abstract class WatchlistSerialState extends Equatable {
  const WatchlistSerialState();

  @override
  List<Object> get props => [];
}

class WatchlistSerialEmpty extends WatchlistSerialState {}

class WatchlistSerialLoading extends WatchlistSerialState {}

class WatchlistSerialError extends WatchlistSerialState {
  final String message;

  const WatchlistSerialError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSerialHasData extends WatchlistSerialState {
  final List<Serial> result;

  const WatchlistSerialHasData(this.result);

  @override
  List<Object> get props => [result];
}
