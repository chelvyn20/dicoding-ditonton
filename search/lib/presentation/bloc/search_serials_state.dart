part of 'search_serials_bloc.dart';

abstract class SearchSerialsState extends Equatable {
  const SearchSerialsState();

  @override
  List<Object> get props => [];
}

class SearchSerialsEmpty extends SearchSerialsState {}

class SearchSerialsLoading extends SearchSerialsState {}

class SearchSerialsError extends SearchSerialsState {
  final String message;

  const SearchSerialsError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchSerialsHasData extends SearchSerialsState {
  final List<Serial> result;

  const SearchSerialsHasData(this.result);

  @override
  List<Object> get props => [result];
}
