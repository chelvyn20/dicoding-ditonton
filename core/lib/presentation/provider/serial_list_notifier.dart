import 'package:core/core.dart';
import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_on_the_air_serials.dart';
import 'package:core/domain/usecases/get_popular_serials.dart';
import 'package:core/domain/usecases/get_top_rated_serials.dart';
import 'package:flutter/foundation.dart';

class SerialListNotifier extends ChangeNotifier {
  final GetOnTheAirSerials getOnTheAirSerials;
  final GetPopularSerials getPopularSerials;
  final GetTopRatedSerials getTopRatedSerials;

  SerialListNotifier({
    required this.getOnTheAirSerials,
    required this.getPopularSerials,
    required this.getTopRatedSerials,
  });

  var _onTheAirSerials = <Serial>[];
  List<Serial> get onTheAirSerials => _onTheAirSerials;

  RequestState _onTheAirState = RequestState.empty;
  RequestState get onTheAirState => _onTheAirState;

  var _popularSerials = <Serial>[];
  List<Serial> get popularSerials => _popularSerials;

  RequestState _popularSerialsState = RequestState.empty;
  RequestState get popularSerialsState => _popularSerialsState;

  var _topRatedSerials = <Serial>[];
  List<Serial> get topRatedSerials => _topRatedSerials;

  RequestState _topRatedSerialsState = RequestState.empty;
  RequestState get topRatedSerialsState => _topRatedSerialsState;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirSerials() async {
    _onTheAirState = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirSerials.execute();
    result.fold(
      (failure) {
        _onTheAirState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (serialsData) {
        _onTheAirState = RequestState.loaded;
        _onTheAirSerials = serialsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularSerials() async {
    _popularSerialsState = RequestState.loading;
    notifyListeners();

    final result = await getPopularSerials.execute();
    result.fold(
      (failure) {
        _popularSerialsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (serialsData) {
        _popularSerialsState = RequestState.loaded;
        _popularSerials = serialsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedSerials() async {
    _topRatedSerialsState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedSerials.execute();
    result.fold(
      (failure) {
        _topRatedSerialsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (serialsData) {
        _topRatedSerialsState = RequestState.loaded;
        _topRatedSerials = serialsData;
        notifyListeners();
      },
    );
  }
}
