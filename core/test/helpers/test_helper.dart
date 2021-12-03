import 'package:core/common/network_info.dart';
import 'package:core/data/datasources/db/movie_database_helper.dart';
import 'package:core/data/datasources/db/serial_database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/serial_local_data_source.dart';
import 'package:core/data/datasources/serial_remote_data_source.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/serial_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/io_client.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  MovieDatabaseHelper,
  SerialRepository,
  SerialRemoteDataSource,
  SerialLocalDataSource,
  SerialDatabaseHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
