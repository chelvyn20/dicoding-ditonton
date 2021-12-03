import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_top_rated_serials.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedSerials usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = GetTopRatedSerials(mockSerialRepository);
  });

  final tSerials = <Serial>[];

  test('should get list of serials from repository', () async {
    // arrange
    when(mockSerialRepository.getTopRatedSerials())
        .thenAnswer((_) async => Right(tSerials));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSerials));
  });
}
