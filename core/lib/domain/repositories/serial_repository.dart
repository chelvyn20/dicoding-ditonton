import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/entities/serial_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SerialRepository {
  Future<Either<Failure, List<Serial>>> getOnTheAirSerials();
  Future<Either<Failure, List<Serial>>> getPopularSerials();
  Future<Either<Failure, List<Serial>>> getTopRatedSerials();
  Future<Either<Failure, SerialDetail>> getSerialDetail(int id);
  Future<Either<Failure, List<Serial>>> getSerialRecommendations(int id);
  Future<Either<Failure, List<Serial>>> searchSerials(String query);
  Future<Either<Failure, String>> saveSerialWatchlist(SerialDetail serial);
  Future<Either<Failure, String>> removeSerialWatchlist(SerialDetail serial);
  Future<bool> isAddedToSerialWatchlist(int id);
  Future<Either<Failure, List<Serial>>> getWatchlistSerial();
}
