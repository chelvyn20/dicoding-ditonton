import 'package:core/domain/entities/serial.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_serials.dart';

import 'debounce.dart';

part 'search_serials_event.dart';
part 'search_serials_state.dart';

class SearchSerialsBloc extends Bloc<SearchSerialsEvent, SearchSerialsState> {
  final SearchSerials _searchSerials;

  SearchSerialsBloc(this._searchSerials) : super(SearchSerialsEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchSerialsLoading());
      final result = await _searchSerials.execute(query);

      result.fold(
        (failure) {
          emit(SearchSerialsError(failure.message));
        },
        (data) {
          emit(SearchSerialsHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
