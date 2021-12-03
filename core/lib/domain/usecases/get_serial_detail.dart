import 'package:core/domain/entities/serial_detail.dart';
import 'package:core/domain/repositories/serial_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetSerialDetail {
  final SerialRepository repository;

  GetSerialDetail(this.repository);

  Future<Either<Failure, SerialDetail>> execute(int id) {
    return repository.getSerialDetail(id);
  }
}
