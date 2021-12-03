import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/repositories/serial_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class SearchSerials {
  final SerialRepository repository;

  SearchSerials(this.repository);

  Future<Either<Failure, List<Serial>>> execute(String query) {
    return repository.searchSerials(query);
  }
}
