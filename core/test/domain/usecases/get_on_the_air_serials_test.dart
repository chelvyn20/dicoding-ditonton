import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_on_the_air_serials.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirSerials usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = GetOnTheAirSerials(mockSerialRepository);
  });

  final tSerials = <Serial>[];

  test('should get list of serials from the repository', () async {
    // arrange
    when(mockSerialRepository.getOnTheAirSerials())
        .thenAnswer((_) async => Right(tSerials));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSerials));
  });
}
