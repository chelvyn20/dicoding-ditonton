import 'package:core/domain/repositories/serial_repository.dart';

class GetWatchListSerialStatus {
  final SerialRepository repository;

  GetWatchListSerialStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToSerialWatchlist(id);
  }
}
