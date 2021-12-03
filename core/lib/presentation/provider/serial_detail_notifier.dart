import 'package:core/core.dart';
import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/entities/serial_detail.dart';
import 'package:core/domain/usecases/get_serial_detail.dart';
import 'package:core/domain/usecases/get_serial_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_serial_status.dart';
import 'package:core/domain/usecases/remove_serial_watchlist.dart';
import 'package:core/domain/usecases/save_serial_watchlist.dart';
import 'package:flutter/foundation.dart';

class SerialDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetSerialDetail getSerialDetail;
  final GetSerialRecommendations getSerialRecommendations;
  final GetWatchListSerialStatus getWatchListStatus;
  final SaveSerialWatchlist saveWatchlist;
  final RemoveSerialWatchlist removeWatchlist;

  SerialDetailNotifier({
    required this.getSerialDetail,
    required this.getSerialRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late SerialDetail _serial;
  SerialDetail get serial => _serial;

  RequestState _serialState = RequestState.empty;
  RequestState get serialState => _serialState;

  List<Serial> _serialRecommendations = [];
  List<Serial> get serialRecommendations => _serialRecommendations;

  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchSerialDetail(int id) async {
    _serialState = RequestState.loading;
    notifyListeners();
    final detailResult = await getSerialDetail.execute(id);
    final recommendationResult = await getSerialRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _serialState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (serial) {
        _recommendationState = RequestState.loading;
        _serial = serial;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (serials) {
            _recommendationState = RequestState.loaded;
            _serialRecommendations = serials;
          },
        );
        _serialState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(SerialDetail serial) async {
    final result = await saveWatchlist.execute(serial);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(serial.id);
  }

  Future<void> removeFromWatchlist(SerialDetail serial) async {
    final result = await removeWatchlist.execute(serial);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(serial.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
