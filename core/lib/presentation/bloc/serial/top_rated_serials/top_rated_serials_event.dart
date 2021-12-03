part of 'top_rated_serials_bloc.dart';

abstract class TopRatedSerialsEvent extends Equatable {
  const TopRatedSerialsEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedSerials extends TopRatedSerialsEvent {
  const FetchTopRatedSerials();

  @override
  List<Object> get props => [];
}
