import 'package:core/data/models/serial_table.dart';
import 'package:core/utils/exception.dart';

import 'db/serial_database_helper.dart';

abstract class SerialLocalDataSource {
  Future<String> insertSerialWatchlist(SerialTable serial);
  Future<String> removeSerialWatchlist(SerialTable serial);
  Future<SerialTable?> getSerialById(int id);
  Future<List<SerialTable>> getWatchlistSerials();
  Future<void> cacheOnTheAirSerials(List<SerialTable> serials);
  Future<List<SerialTable>> getCachedOnTheAirSerials();
}

class SerialLocalDataSourceImpl implements SerialLocalDataSource {
  final SerialDatabaseHelper serialDatabaseHelper;

  SerialLocalDataSourceImpl({
    required this.serialDatabaseHelper,
  });

  @override
  Future<SerialTable?> getSerialById(int id) async {
    final result = await serialDatabaseHelper.getSerialById(id);
    if (result != null) {
      return SerialTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<SerialTable>> getWatchlistSerials() async {
    final result = await serialDatabaseHelper.getWatchlistSerials();
    return result.map((data) => SerialTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertSerialWatchlist(SerialTable serial) async {
    try {
      await serialDatabaseHelper.insertSerialWatchlist(serial);
      return 'Added serial to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeSerialWatchlist(SerialTable serial) async {
    try {
      await serialDatabaseHelper.removeSerialWatchlist(serial);
      return 'Removed serial from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> cacheOnTheAirSerials(List<SerialTable> serials) async {
    await serialDatabaseHelper.clearSerialCache('on the air');
    await serialDatabaseHelper.insertSerialCacheTransaction(
        serials, 'on the air');
  }

  @override
  Future<List<SerialTable>> getCachedOnTheAirSerials() async {
    final result = await serialDatabaseHelper.getCacheSerials('on the air');
    if (result.isNotEmpty) {
      return result.map((data) => SerialTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
