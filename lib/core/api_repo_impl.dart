import 'dart:developer';

import 'package:http/http.dart';
import 'package:hybrid/core/api.dart';
import 'package:hybrid/core/api_resository.dart';
import 'package:hybrid/core/type_def.dart';

class ApiRepositoryImpl implements ApiRepository {
  final API api;

  ApiRepositoryImpl({required this.api});

  @override
  FutureEither<Response> get(String url,
      {bool requireAuth = false, Map<String, dynamic>? queryParameters}) async {
       
    return await api.getRequest(
        url: url, requireAuth: requireAuth, queryParams: queryParameters);
  }

  @override
  FutureEither<Response> post(String url, dynamic body,
      {bool requireAuth = true}) async {
    return await api.postRequest(
        url: url, body: body, requireAuth: requireAuth);
  }

  @override
  FutureEither<Response> put(String url, dynamic body,
      {bool requireAuth = true}) async {
    return await api.putRequest(url: url, body: body, requireAuth: requireAuth);
  }

  @override
  FutureEither<Response> delete(String url, dynamic body,
      {bool requireAuth = true}) async {
    return await api.deleteRequest(
        url: url, body: body, requireAuth: requireAuth);
  }
}
