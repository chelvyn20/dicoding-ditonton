import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/bloc/movie/popular_movies/popular_movies_bloc.dart';
import 'package:core/presentation/pages/movie/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularMoviesBloc extends Mock implements PopularMoviesBloc {}

class PopularMoviesEventFake extends Fake implements PopularMoviesEvent {}

class PopularMoviesStateFake extends Fake implements PopularMoviesState {}

void main() {
  late PopularMoviesBloc popularMoviesBloc;

  setUpAll(() {
    registerFallbackValue(PopularMoviesEventFake());
    registerFallbackValue(PopularMoviesStateFake());
  });

  setUp(() {
    popularMoviesBloc = MockPopularMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>.value(
      value: popularMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => popularMoviesBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesLoading()));
    when(() => popularMoviesBloc.state).thenReturn(PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => popularMoviesBloc.stream)
        .thenAnswer((_) => Stream.value(const PopularMoviesHasData(<Movie>[])));
    when(() => popularMoviesBloc.state)
        .thenReturn(const PopularMoviesHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => popularMoviesBloc.stream).thenAnswer(
        (_) => Stream.value(const PopularMoviesError('Error message')));
    when(() => popularMoviesBloc.state)
        .thenReturn(const PopularMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
