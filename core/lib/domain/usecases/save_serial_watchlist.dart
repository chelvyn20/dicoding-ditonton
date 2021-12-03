import 'package:core/domain/entities/serial_detail.dart';
import 'package:core/domain/repositories/serial_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class SaveSerialWatchlist {
  final SerialRepository repository;

  SaveSerialWatchlist(this.repository);

  Future<Either<Failure, String>> execute(SerialDetail serial) {
    return repository.saveSerialWatchlist(serial);
  }
}
