part of 'search_serials_bloc.dart';

abstract class SearchSerialsEvent extends Equatable {
  const SearchSerialsEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchSerialsEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
