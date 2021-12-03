import 'package:core/domain/entities/serial.dart';
import 'package:core/presentation/bloc/serial/watchlist_serial/watchlist_serial_bloc.dart';
import 'package:core/presentation/pages/serial/watchlist_serial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistSerialBloc extends Mock implements WatchlistSerialBloc {}

class WatchlistSerialEventFake extends Fake implements WatchlistSerialEvent {}

class WatchlistSerialStateFake extends Fake implements WatchlistSerialState {}

void main() {
  late WatchlistSerialBloc watchlistSerialBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistSerialEventFake());
    registerFallbackValue(WatchlistSerialStateFake());
  });

  setUp(() {
    watchlistSerialBloc = MockWatchlistSerialBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistSerialBloc>.value(
      value: watchlistSerialBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tSerial = Serial(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    originalLanguage: 'originalLanguage',
    originCountry: ['originCountry'],
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tSerialList = <Serial>[tSerial];

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => watchlistSerialBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistSerialLoading()));
    when(() => watchlistSerialBloc.state).thenReturn(WatchlistSerialLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistSerialPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display no data when data is empty',
      (WidgetTester tester) async {
    when(() => watchlistSerialBloc.stream).thenAnswer(
        (_) => Stream.value(const WatchlistSerialHasData(<Serial>[])));
    when(() => watchlistSerialBloc.state)
        .thenReturn(const WatchlistSerialHasData(<Serial>[]));

    final textFinder = find.byKey(const Key('no_data'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistSerialPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => watchlistSerialBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistSerialHasData(tSerialList)));
    when(() => watchlistSerialBloc.state)
        .thenReturn(WatchlistSerialHasData(tSerialList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistSerialPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => watchlistSerialBloc.stream).thenAnswer(
        (_) => Stream.value(const WatchlistSerialError('Error message')));
    when(() => watchlistSerialBloc.state)
        .thenReturn(const WatchlistSerialError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistSerialPage()));

    expect(textFinder, findsOneWidget);
  });
}
