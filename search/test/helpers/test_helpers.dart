import 'package:core/common/network_info.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/serial_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/io_client.dart';

@GenerateMocks([
  MovieRepository,
  SerialRepository,
  NetworkInfo,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
