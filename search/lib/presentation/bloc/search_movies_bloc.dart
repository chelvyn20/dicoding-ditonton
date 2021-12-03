import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';

import 'debounce.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies _searchMovies;

  SearchMoviesBloc(this._searchMovies) : super(SearchMoviesEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchMoviesLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchMoviesError(failure.message));
        },
        (data) {
          emit(SearchMoviesHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
