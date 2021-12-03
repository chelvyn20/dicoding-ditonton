import 'package:core/domain/entities/serial.dart';
import 'package:core/domain/usecases/get_popular_serials.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularSerials usecase;
  late MockSerialRepository mockSerialRpository;

  setUp(() {
    mockSerialRpository = MockSerialRepository();
    usecase = GetPopularSerials(mockSerialRpository);
  });

  final tSerials = <Serial>[];

  group('GetPopularSerials Tests', () {
    group('execute', () {
      test(
          'should get list of serials from the repository when execute function is called',
          () async {
        // arrange
        when(mockSerialRpository.getPopularSerials())
            .thenAnswer((_) async => Right(tSerials));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tSerials));
      });
    });
  });
}
