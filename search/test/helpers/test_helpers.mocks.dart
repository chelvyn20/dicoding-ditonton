// Mocks generated by Mockito 5.0.16 from annotations
// in search/test/helpers/test_helpers.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:convert' as _i16;
import 'dart:typed_data' as _i17;

import 'package:core/common/network_info.dart' as _i13;
import 'package:core/domain/entities/movie.dart' as _i8;
import 'package:core/domain/entities/movie_detail.dart' as _i9;
import 'package:core/domain/entities/serial.dart' as _i11;
import 'package:core/domain/entities/serial_detail.dart' as _i12;
import 'package:core/domain/repositories/movie_repository.dart' as _i5;
import 'package:core/domain/repositories/serial_repository.dart' as _i10;
import 'package:core/utils/failure.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/src/base_request.dart' as _i15;
import 'package:http/src/io_client.dart' as _i14;
import 'package:http/src/io_streamed_response.dart' as _i3;
import 'package:http/src/response.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeIOStreamedResponse_1 extends _i1.Fake
    implements _i3.IOStreamedResponse {}

class _FakeResponse_2 extends _i1.Fake implements _i4.Response {}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i5.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, _i9.MovieDetail>>.value(
              _FakeEither_0<_i7.Failure, _i9.MovieDetail>())) as _i6
          .Future<_i2.Either<_i7.Failure, _i9.MovieDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveMovieWatchlist(
          _i9.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveMovieWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeMovieWatchlist(
          _i9.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeMovieWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToMovieWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToMovieWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getWatchlistMovie() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovie, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SerialRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSerialRepository extends _i1.Mock implements _i10.SerialRepository {
  MockSerialRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Serial>>> getOnTheAirSerials() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirSerials, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>.value(
              _FakeEither_0<_i7.Failure, List<_i11.Serial>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Serial>>> getPopularSerials() =>
      (super.noSuchMethod(Invocation.method(#getPopularSerials, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>.value(
              _FakeEither_0<_i7.Failure, List<_i11.Serial>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Serial>>> getTopRatedSerials() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedSerials, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>.value(
              _FakeEither_0<_i7.Failure, List<_i11.Serial>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i12.SerialDetail>> getSerialDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getSerialDetail, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, _i12.SerialDetail>>.value(
              _FakeEither_0<_i7.Failure, _i12.SerialDetail>())) as _i6
          .Future<_i2.Either<_i7.Failure, _i12.SerialDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>
      getSerialRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getSerialRecommendations, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>.value(
              _FakeEither_0<_i7.Failure, List<_i11.Serial>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Serial>>> searchSerials(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchSerials, [query]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>.value(
              _FakeEither_0<_i7.Failure, List<_i11.Serial>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveSerialWatchlist(
          _i12.SerialDetail? serial) =>
      (super.noSuchMethod(Invocation.method(#saveSerialWatchlist, [serial]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeSerialWatchlist(
          _i12.SerialDetail? serial) =>
      (super.noSuchMethod(Invocation.method(#removeSerialWatchlist, [serial]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToSerialWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToSerialWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Serial>>> getWatchlistSerial() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistSerial, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>.value(
              _FakeEither_0<_i7.Failure, List<_i11.Serial>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.Serial>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i13.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [IOClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOClient extends _i1.Mock implements _i14.IOClient {
  MockIOClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i3.IOStreamedResponse> send(_i15.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue: Future<_i3.IOStreamedResponse>.value(
                  _FakeIOStreamedResponse_1()))
          as _i6.Future<_i3.IOStreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  _i6.Future<_i4.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i16.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i16.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i16.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i16.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i17.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i17.Uint8List>.value(_i17.Uint8List(0)))
          as _i6.Future<_i17.Uint8List>);
  @override
  String toString() => super.toString();
}
