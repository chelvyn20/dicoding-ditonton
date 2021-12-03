import 'package:about/about.dart';
import 'package:core/common/utils.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/movie/popular_movies/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/movie/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/serial/popular_serials/popular_serials_bloc.dart';
import 'package:core/presentation/bloc/serial/top_rated_serials/top_rated_serials_bloc.dart';
import 'package:core/presentation/bloc/serial/watchlist_serial/watchlist_serial_bloc.dart';
import 'package:core/presentation/pages/movie/home_movie_page.dart';
import 'package:core/presentation/pages/movie/movie_detail_page.dart';
import 'package:core/presentation/pages/movie/popular_movies_page.dart';
import 'package:core/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:core/presentation/pages/movie/watchlist_movie_page.dart';
import 'package:core/presentation/pages/serial/home_serial_page.dart';
import 'package:core/presentation/pages/serial/popular_serials_page.dart';
import 'package:core/presentation/pages/serial/serial_detail_page.dart';
import 'package:core/presentation/pages/serial/top_rated_serials_page.dart';
import 'package:core/presentation/pages/serial/watchlist_serial_page.dart';
import 'package:core/presentation/provider/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie_list_notifier.dart';
import 'package:core/presentation/provider/serial_detail_notifier.dart';
import 'package:core/presentation/provider/serial_list_notifier.dart';
import 'package:core/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/injection.dart' as di;

import 'package:search/presentation/bloc/search_movies_bloc.dart';
import 'package:search/presentation/bloc/search_serials_bloc.dart';
import 'package:search/presentation/pages/search_movie_page.dart';
import 'package:search/presentation/pages/search_serial_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // movie-provider
        ChangeNotifierProvider(create: (_) => di.locator<MovieListNotifier>()),
        ChangeNotifierProvider(
            create: (_) => di.locator<MovieDetailNotifier>()),

        //movie-bloc
        BlocProvider(create: (_) => di.locator<PopularMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<SearchMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistMovieBloc>()),
        //*

        //serial-provider
        ChangeNotifierProvider(create: (_) => di.locator<SerialListNotifier>()),
        ChangeNotifierProvider(
            create: (_) => di.locator<SerialDetailNotifier>()),

        //serial-bloc
        BlocProvider(create: (_) => di.locator<PopularSerialsBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedSerialsBloc>()),
        BlocProvider(create: (_) => di.locator<SearchSerialsBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistSerialBloc>()),
        //*
      ],
      child: MaterialApp(
        title: 'Ditonton',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HOME_MOVIE_ROUTE:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case POPULAR_MOVIES_ROUTE:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case TOP_RATED_MOVIES_ROUTE:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case DETAIL_MOVIE_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_MOVIE_ROUTE:
              return MaterialPageRoute(builder: (_) => SearchMoviePage());
            case WATCHLIST_MOVIE_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviePage());

            case HOME_SERIAL_ROUTE:
              return MaterialPageRoute(builder: (_) => HomeSerialPage());
            case POPULAR_SERIALS_ROUTE:
              return MaterialPageRoute(builder: (_) => PopularSerialsPage());
            case TOP_RATED_SERIALS_ROUTE:
              return MaterialPageRoute(builder: (_) => TopRatedSerialsPage());
            case DETAIL_SERIAL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SerialDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_SERIAL_ROUTE:
              return MaterialPageRoute(builder: (_) => SearchSerialPage());
            case WATCHLIST_SERIAL_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistSerialPage());

            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
