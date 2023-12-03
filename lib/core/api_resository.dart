// domain/repository/api_repository.dart
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:hybrid/core/type_def.dart';

abstract class ApiRepository {
  FutureEither<Response> get(String url, {bool requireAuth = true,Map<String, dynamic>? queryParameters});
  FutureEither<Response> post(String url, dynamic body, {bool requireAuth = true});
  FutureEither<Response> put(String url, dynamic body, {bool requireAuth = true});
  FutureEither<Response> delete(String url, dynamic body, {bool requireAuth = true});
}
