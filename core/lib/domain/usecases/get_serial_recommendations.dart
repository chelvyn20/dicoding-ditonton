import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/repositories/serial_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetSerialRecommendations {
  final SerialRepository repository;

  GetSerialRecommendations(this.repository);

  Future<Either<Failure, List<Serial>>> execute(id) {
    return repository.getSerialRecommendations(id);
  }
}
