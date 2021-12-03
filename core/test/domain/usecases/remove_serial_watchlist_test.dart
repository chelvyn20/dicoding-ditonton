import 'package:core/domain/usecases/remove_serial_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_serial_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveSerialWatchlist usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = RemoveSerialWatchlist(mockSerialRepository);
  });

  test('should remove watchlist serial from repository', () async {
    // arrange
    when(mockSerialRepository.removeSerialWatchlist(testSerialDetail))
        .thenAnswer((_) async => const Right('Removed serial from watchlist'));
    // act
    final result = await usecase.execute(testSerialDetail);
    // assert
    verify(mockSerialRepository.removeSerialWatchlist(testSerialDetail));
    expect(result, const Right('Removed serial from watchlist'));
  });
}
