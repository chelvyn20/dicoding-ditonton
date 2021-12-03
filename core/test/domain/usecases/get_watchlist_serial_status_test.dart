import 'package:core/domain/usecases/get_watchlist_serial_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListSerialStatus usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = GetWatchListSerialStatus(mockSerialRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockSerialRepository.isAddedToSerialWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
