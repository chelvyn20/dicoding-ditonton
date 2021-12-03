import 'package:core/domain/entities/serial.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_serials.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SearchSerials usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = SearchSerials(mockSerialRepository);
  });

  final tSerials = <Serial>[];
  const tQuery = 'vincenzo';

  test('should get list of serials from the repository', () async {
    // arrange
    when(mockSerialRepository.searchSerials(tQuery))
        .thenAnswer((_) async => Right(tSerials));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSerials));
  });
}
