part of 'popular_serials_bloc.dart';

abstract class PopularSerialsEvent extends Equatable {
  const PopularSerialsEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularSerials extends PopularSerialsEvent {
  const FetchPopularSerials();

  @override
  List<Object> get props => [];
}
