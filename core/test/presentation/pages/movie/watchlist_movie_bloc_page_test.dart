import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/pages/movie/watchlist_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistMovieBloc extends Mock implements WatchlistMovieBloc {}

class WatchlistMovieEventFake extends Fake implements WatchlistMovieEvent {}

class WatchlistMovieStateFake extends Fake implements WatchlistMovieState {}

void main() {
  late WatchlistMovieBloc watchlistMovieBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistMovieEventFake());
    registerFallbackValue(WatchlistMovieStateFake());
  });

  setUp(() {
    watchlistMovieBloc = MockWatchlistMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>.value(
      value: watchlistMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tSerialList = <Movie>[tMovie];

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => watchlistMovieBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistMovieLoading()));
    when(() => watchlistMovieBloc.state).thenReturn(WatchlistMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviePage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display no data when data is empty',
      (WidgetTester tester) async {
    when(() => watchlistMovieBloc.stream).thenAnswer(
        (_) => Stream.value(const WatchlistMovieHasData(<Movie>[])));
    when(() => watchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieHasData(<Movie>[]));

    final textFinder = find.byKey(const Key('no_data'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviePage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => watchlistMovieBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistMovieHasData(tSerialList)));
    when(() => watchlistMovieBloc.state)
        .thenReturn(WatchlistMovieHasData(tSerialList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviePage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => watchlistMovieBloc.stream).thenAnswer(
        (_) => Stream.value(const WatchlistMovieError('Error message')));
    when(() => watchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviePage()));

    expect(textFinder, findsOneWidget);
  });
}
