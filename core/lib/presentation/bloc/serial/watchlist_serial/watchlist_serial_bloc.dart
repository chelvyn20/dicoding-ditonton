import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_watchlist_serial.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_serial_event.dart';
part 'watchlist_serial_state.dart';

class WatchlistSerialBloc
    extends Bloc<WatchlistSerialEvent, WatchlistSerialState> {
  final GetWatchlistSerial _getWatchlistSerial;

  WatchlistSerialBloc(this._getWatchlistSerial)
      : super(WatchlistSerialEmpty()) {
    on<FetchWatchlistSerial>(
      (event, emit) async {
        emit(WatchlistSerialLoading());
        final result = await _getWatchlistSerial.execute();

        result.fold(
          (failure) {
            emit(WatchlistSerialError(failure.message));
          },
          (data) {
            emit(WatchlistSerialHasData(data));
          },
        );
      },
    );
  }
}
