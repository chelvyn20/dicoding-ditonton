import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_popular_serials.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_serials_event.dart';
part 'popular_serials_state.dart';

class PopularSerialsBloc
    extends Bloc<PopularSerialsEvent, PopularSerialsState> {
  final GetPopularSerials _getPopularSerials;

  PopularSerialsBloc(this._getPopularSerials) : super(PopularSerialsEmpty()) {
    on<FetchPopularSerials>((event, emit) async {
      emit(PopularSerialsLoading());
      final result = await _getPopularSerials.execute();

      result.fold(
        (failure) {
          emit(PopularSerialsError(failure.message));
        },
        (data) {
          emit(PopularSerialsHasData(data));
        },
      );
    });
  }
}
