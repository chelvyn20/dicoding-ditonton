import 'package:core/domain/usecases/save_serial_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_serial_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveSerialWatchlist usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = SaveSerialWatchlist(mockSerialRepository);
  });

  test('should save serial to the repository', () async {
    // arrange
    when(mockSerialRepository.saveSerialWatchlist(testSerialDetail))
        .thenAnswer((_) async => const Right('Added serial to Watchlist'));
    // act
    final result = await usecase.execute(testSerialDetail);
    // assert
    verify(mockSerialRepository.saveSerialWatchlist(testSerialDetail));
    expect(result, const Right('Added serial to Watchlist'));
  });
}
