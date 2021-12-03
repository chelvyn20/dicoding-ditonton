part of 'popular_serials_bloc.dart';

abstract class PopularSerialsState extends Equatable {
  const PopularSerialsState();

  @override
  List<Object> get props => [];
}

class PopularSerialsEmpty extends PopularSerialsState {}

class PopularSerialsLoading extends PopularSerialsState {}

class PopularSerialsError extends PopularSerialsState {
  final String message;

  const PopularSerialsError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularSerialsHasData extends PopularSerialsState {
  final List<Serial> result;

  const PopularSerialsHasData(this.result);

  @override
  List<Object> get props => [result];
}
