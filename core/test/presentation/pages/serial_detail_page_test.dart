import 'package:core/domain/entities/serial.dart';
import 'package:core/presentation/pages/serial/serial_detail_page.dart';
import 'package:core/presentation/provider/serial_detail_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_serial_objects.dart';
import 'serial_detail_page_test.mocks.dart';

@GenerateMocks([SerialDetailNotifier])
void main() {
  late MockSerialDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSerialDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SerialDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when serial not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.serialState).thenReturn(RequestState.loaded);
    when(mockNotifier.serial).thenReturn(testSerialDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.serialRecommendations).thenReturn(<Serial>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const SerialDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when serial is added serial to wathchlist',
      (WidgetTester tester) async {
    when(mockNotifier.serialState).thenReturn(RequestState.loaded);
    when(mockNotifier.serial).thenReturn(testSerialDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.serialRecommendations).thenReturn(<Serial>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const SerialDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added serial to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.serialState).thenReturn(RequestState.loaded);
    when(mockNotifier.serial).thenReturn(testSerialDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.serialRecommendations).thenReturn(<Serial>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const SerialDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add serial to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.serialState).thenReturn(RequestState.loaded);
    when(mockNotifier.serial).thenReturn(testSerialDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.serialRecommendations).thenReturn(<Serial>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const SerialDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
