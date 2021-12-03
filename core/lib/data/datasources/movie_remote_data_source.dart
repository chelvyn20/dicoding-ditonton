import 'dart:convert';

import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_model.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:core/utils/exception.dart';
import 'package:http/io_client.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const _API_KEY = 'api_key=62c20507bd01d0795c9ee23ee915cfb0';
  static const _BASE_URL = 'https://api.themoviedb.org/3';

  final IOClient ioClient;

  MovieRemoteDataSourceImpl({required this.ioClient});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response =
        await ioClient.get(Uri.parse('$_BASE_URL/movie/now_playing?$_API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    // HttpClient client = HttpClient(context: await globalContext);
    // client.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => false;
    // IOClient ioClient = IOClient(client);
    final response =
        await ioClient.get(Uri.parse('$_BASE_URL/movie/popular?$_API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    // HttpClient client = HttpClient(context: await globalContext);
    // client.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => false;
    // IOClient ioClient = IOClient(client);
    final response =
        await ioClient.get(Uri.parse('$_BASE_URL/movie/top_rated?$_API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    // HttpClient client = HttpClient(context: await globalContext);
    // client.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => false;
    // IOClient ioClient = IOClient(client);
    final response =
        await ioClient.get(Uri.parse('$_BASE_URL/movie/$id?$_API_KEY'));

    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    // HttpClient client = HttpClient(context: await globalContext);
    // client.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => false;
    // IOClient ioClient = IOClient(client);
    final response = await ioClient
        .get(Uri.parse('$_BASE_URL/movie/$id/recommendations?$_API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    // HttpClient client = HttpClient(context: await globalContext);
    // client.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => false;
    // IOClient ioClient = IOClient(client);
    final response = await ioClient
        .get(Uri.parse('$_BASE_URL/search/movie?$_API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
