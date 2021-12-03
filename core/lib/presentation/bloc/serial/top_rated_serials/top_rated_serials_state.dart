part of 'top_rated_serials_bloc.dart';

abstract class TopRatedSerialsState extends Equatable {
  const TopRatedSerialsState();

  @override
  List<Object> get props => [];
}

class TopRatedSerialsEmpty extends TopRatedSerialsState {}

class TopRatedSerialsLoading extends TopRatedSerialsState {}

class TopRatedSerialsError extends TopRatedSerialsState {
  final String message;

  const TopRatedSerialsError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedSerialsHasData extends TopRatedSerialsState {
  final List<Serial> result;

  const TopRatedSerialsHasData(this.result);

  @override
  List<Object> get props => [result];
}
