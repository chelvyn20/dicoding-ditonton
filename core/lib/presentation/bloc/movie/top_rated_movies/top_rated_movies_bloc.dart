import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<FetchTopRatedMovies>(
      (event, emit) async {
        emit(TopRatedMoviesLoading());
        final result = await _getTopRatedMovies.execute();

        result.fold(
          (failure) {
            emit(TopRatedMoviesError(failure.message));
          },
          (data) {
            emit(TopRatedMoviesHasData(data));
          },
        );
      },
    );
  }
}
