import 'package:core/domain/entities/serial.dart';
import 'package:core/presentation/bloc/serial/top_rated_serials/top_rated_serials_bloc.dart';
import 'package:core/presentation/pages/serial/top_rated_serials_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTopRatedSerialsBloc extends Mock implements TopRatedSerialsBloc {}

class TopRatedSerialsEventFake extends Fake implements TopRatedSerialsEvent {}

class TopRatedSerialsStateFake extends Fake implements TopRatedSerialsState {}

void main() {
  late TopRatedSerialsBloc topRatedSerialsBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedSerialsEventFake());
    registerFallbackValue(TopRatedSerialsStateFake());
  });

  setUp(() {
    topRatedSerialsBloc = MockTopRatedSerialsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedSerialsBloc>.value(
      value: topRatedSerialsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => topRatedSerialsBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedSerialsLoading()));
    when(() => topRatedSerialsBloc.state).thenReturn(TopRatedSerialsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedSerialsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => topRatedSerialsBloc.stream).thenAnswer(
        (_) => Stream.value(const TopRatedSerialsHasData(<Serial>[])));
    when(() => topRatedSerialsBloc.state)
        .thenReturn(const TopRatedSerialsHasData(<Serial>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedSerialsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => topRatedSerialsBloc.stream).thenAnswer(
        (_) => Stream.value(const TopRatedSerialsError('Error message')));
    when(() => topRatedSerialsBloc.state)
        .thenReturn(const TopRatedSerialsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedSerialsPage()));

    expect(textFinder, findsOneWidget);
  });
}
