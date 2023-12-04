// domain/repository/api_repository.dart
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hybrid/core/type_def.dart';

abstract class ApiRepository {
  FutureEither<Response> get(String url,
      {bool requireAuth = true,
      Map<String, dynamic>? queryParameters,
      String? token});
  FutureEither<Response> post(String url, dynamic body,
      {bool requireAuth = true, required String token});
  FutureEither<Response> put(String url, dynamic body,
      {bool requireAuth = true, required String token});
  FutureEither<Response> delete(String url, dynamic body,
      {bool requireAuth = true, required String token});
}
