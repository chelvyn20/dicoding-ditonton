import 'package:core/domain/usecases/get_serial_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_serial_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSerialDetail usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = GetSerialDetail(mockSerialRepository);
  });

  const tId = 1;

  test('should get serial detail from the repository', () async {
    // arrange
    when(mockSerialRepository.getSerialDetail(tId))
        .thenAnswer((_) async => const Right(testSerialDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, const Right(testSerialDetail));
  });
}
