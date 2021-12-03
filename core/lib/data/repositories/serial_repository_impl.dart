import 'dart:io';

import 'package:core/common/network_info.dart';
import 'package:core/core.dart';
import 'package:core/data/datasources/serial_local_data_source.dart';
import 'package:core/data/datasources/serial_remote_data_source.dart';
import 'package:core/data/models/serial_table.dart';
import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/entities/serial_detail.dart';
import 'package:core/domain/repositories/serial_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class SerialRepositoryImpl implements SerialRepository {
  final SerialRemoteDataSource serialRemoteDataSource;
  final SerialLocalDataSource serialLocalDataSource;
  final NetworkInfo networkInfo;

  SerialRepositoryImpl({
    required this.serialRemoteDataSource,
    required this.serialLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Serial>>> getOnTheAirSerials() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await serialRemoteDataSource.getOnTheAirSerials();
        serialLocalDataSource.cacheOnTheAirSerials(
            result.map((serial) => SerialTable.fromDTO(serial)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await serialLocalDataSource.getCachedOnTheAirSerials();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Serial>>> getPopularSerials() async {
    try {
      final result = await serialRemoteDataSource.getPopularSerials();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, SerialDetail>> getSerialDetail(int id) async {
    try {
      final result = await serialRemoteDataSource.getSerialDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Serial>>> getSerialRecommendations(int id) async {
    try {
      final result = await serialRemoteDataSource.getSerialRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Serial>>> getTopRatedSerials() async {
    try {
      final result = await serialRemoteDataSource.getTopRatedSerials();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Serial>>> getWatchlistSerial() async {
    final result = await serialLocalDataSource.getWatchlistSerials();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToSerialWatchlist(int id) async {
    final result = await serialLocalDataSource.getSerialById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeSerialWatchlist(
      SerialDetail serial) async {
    try {
      final result = await serialLocalDataSource
          .removeSerialWatchlist(SerialTable.fromEntity(serial));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveSerialWatchlist(
      SerialDetail serial) async {
    try {
      final result = await serialLocalDataSource
          .insertSerialWatchlist(SerialTable.fromEntity(serial));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Serial>>> searchSerials(String query) async {
    try {
      final result = await serialRemoteDataSource.searchSerials(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
