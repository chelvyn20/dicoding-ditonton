import 'package:core/domain/entities/serial.dart';
import 'package:core/presentation/bloc/serial/popular_serials/popular_serials_bloc.dart';
import 'package:core/presentation/pages/serial/popular_serials_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularSerialsBloc extends Mock implements PopularSerialsBloc {}

class PopularSerialsEventFake extends Fake implements PopularSerialsEvent {}

class PopularSerialsStateFake extends Fake implements PopularSerialsState {}

void main() {
  late PopularSerialsBloc popularSerialsBloc;

  setUpAll(() {
    registerFallbackValue(PopularSerialsEventFake());
    registerFallbackValue(PopularSerialsStateFake());
  });

  setUp(() {
    popularSerialsBloc = MockPopularSerialsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularSerialsBloc>.value(
      value: popularSerialsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => popularSerialsBloc.stream)
        .thenAnswer((_) => Stream.value(PopularSerialsLoading()));
    when(() => popularSerialsBloc.state).thenReturn(PopularSerialsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularSerialsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => popularSerialsBloc.stream).thenAnswer(
        (_) => Stream.value(const PopularSerialsHasData(<Serial>[])));
    when(() => popularSerialsBloc.state)
        .thenReturn(const PopularSerialsHasData(<Serial>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularSerialsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => popularSerialsBloc.stream).thenAnswer(
        (_) => Stream.value(const PopularSerialsError('Error message')));
    when(() => popularSerialsBloc.state)
        .thenReturn(const PopularSerialsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularSerialsPage()));

    expect(textFinder, findsOneWidget);
  });
}
