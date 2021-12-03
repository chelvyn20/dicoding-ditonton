import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_top_rated_serials.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_serials_event.dart';
part 'top_rated_serials_state.dart';

class TopRatedSerialsBloc
    extends Bloc<TopRatedSerialsEvent, TopRatedSerialsState> {
  final GetTopRatedSerials _getTopRatedSerials;

  TopRatedSerialsBloc(this._getTopRatedSerials)
      : super(TopRatedSerialsEmpty()) {
    on<FetchTopRatedSerials>(
      (event, emit) async {
        emit(TopRatedSerialsLoading());
        final result = await _getTopRatedSerials.execute();

        result.fold(
          (failure) {
            emit(TopRatedSerialsError(failure.message));
          },
          (data) {
            emit(TopRatedSerialsHasData(data));
          },
        );
      },
    );
  }
}
