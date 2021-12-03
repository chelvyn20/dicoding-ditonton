import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_serial_recommendations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSerialRecommendations usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = GetSerialRecommendations(mockSerialRepository);
  });

  const tId = 1;
  final tSerials = <Serial>[];

  test('should get list of serial recommendations from the repository',
      () async {
    // arrange
    when(mockSerialRepository.getSerialRecommendations(tId))
        .thenAnswer((_) async => Right(tSerials));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tSerials));
  });
}
