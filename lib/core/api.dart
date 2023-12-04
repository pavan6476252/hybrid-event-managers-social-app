// import 'dart:convert';
// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:http/http.dart';

// import 'core.dart';

// /// Watch apiProvider to make sure to have the latest authToken passed.

// /// Contains common methods required for client side APIs [GET, POST, PUT, DELETE].
// /// Pass the [url] from endpoints using [Endpoints] class.
// /// Every method has an optional parameter [requireAuth] default [true].
// /// Set [requireAuth] to [false] if [authToken] is Empty.
// class API {
//   final String? _authToken;

//   API({required String? authToken}) : _authToken = authToken;

//   FutureEither<Response> getRequest({
//     required String url,
//     Map<String, dynamic>? queryParams,
//     bool requireAuth = true,
//   }) async {
//     final Map<String, String> requestHeaders = {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $_authToken"
//     };

//     if (requireAuth) {
//       if ((_authToken ?? '').isEmpty) {
//         return Left(Failure(message: FailureMessage.authTokenEmpty));
//       }
//     }

//     if (queryParams != null && queryParams.isNotEmpty) {
//       final uri = Uri.parse(url).replace(queryParameters: queryParams);
//       url = uri.toString();
//     }

//     if (AppConfig.logHttp) {
//       log('REQUEST TO : $url', name: LogLabel.httpGet);
//       log('requireAuth : $requireAuth', name: LogLabel.httpGet);
//     }

//     try {
//       final response = await get(Uri.parse(url), headers: requestHeaders);
//       log('RESPONSE : ${response.body}', name: LogLabel.httpGet);
//       return Right(response);
//     } catch (e, stktrc) {
//       return Left(Failure(
//           message: FailureMessage.getRequestMessage, stackTrace: stktrc));
//     }
//   }

//   FutureEither<Response> postRequest(
//       {required String url, dynamic body, bool requireAuth = true}) async {
//     String? token = await FirebaseAuth.instance.currentUser?.getIdToken();

//     final Map<String, String> requestHeaders = {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $token"
//     };
//     if (requireAuth) {
//       if ((token ?? '').isEmpty) {
//         return Left(Failure(message: FailureMessage.authTokenEmpty));
//       }
//     }
//     if (AppConfig.logHttp) {
//       log('REQUEST TO : $url', name: LogLabel.httpPost);
//       log('requireAuth : $requireAuth', name: LogLabel.httpPost);
//       log('BODY : $body', name: LogLabel.httpPost);
//     }
//     try {

//       final response = await post(Uri.parse(url),
//           body: jsonEncode(body), headers: requestHeaders);
//       log('RESPONSE : ${response.body}', name: LogLabel.httpPost);
//       return Right(response);
//     } catch (e, stktrc) {
//       return Left(Failure(
//           message: FailureMessage.postRequestMessage, stackTrace: stktrc));
//     }
//   }

//   FutureEither<Response> putRequest(
//       {required String url, dynamic body, bool requireAuth = true}) async {
//     final Map<String, String> requestHeaders = {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $_authToken"
//     };
//     if (requireAuth) {
//       if ((_authToken ?? '').isEmpty) {
//         return Left(Failure(message: FailureMessage.authTokenEmpty));
//       }
//     }
//     if (AppConfig.logHttp) {
//       log('REQUEST TO : $url', name: LogLabel.httpPut);
//       log(
//         'requireAuth : $requireAuth',
//         name: LogLabel.httpPut,
//       );
//       log('BODY : $body', name: LogLabel.httpPut);
//     }
//     try {
//       final response = await put(Uri.parse(url),
//           body: jsonEncode(body), headers: requestHeaders);
//       log('RESPONSE : ${response.body}', name: LogLabel.httpPut);
//       return Right(response);
//     } catch (e, stktrc) {
//       return Left(Failure(
//           message: FailureMessage.putRequestMessage, stackTrace: stktrc));
//     }
//   }

//   FutureEither<Response> deleteRequest(
//       {required String url, dynamic body, bool requireAuth = true}) async {
//     final Map<String, String> requestHeaders = {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $_authToken"
//     };
//     if (requireAuth) {
//       if ((_authToken ?? '').isEmpty) {
//         return Left(Failure(message: FailureMessage.authTokenEmpty));
//       }
//     }
//     if (AppConfig.logHttp) {
//       log('REQUEST TO : $url', name: LogLabel.httpDelete);
//       log('requireAuth : $requireAuth', name: LogLabel.httpDelete);
//       log('BODY : $body', name: LogLabel.httpDelete);
//     }
//     try {
//       final response = await put(Uri.parse(url),
//           body: jsonEncode(body), headers: requestHeaders);
//       log('RESPONSE : ${response.body}', name: LogLabel.httpDelete);
//       return Right(response);
//     } catch (e, stktrc) {
//       return Left(Failure(
//           message: FailureMessage.deleteRequestMessage, stackTrace: stktrc));
//     }
//   }
// }

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hybrid/core/failure.dart';
import 'package:hybrid/core/type_def.dart';

class AppConfig {
  static bool logHttp = true;
}

class LogLabel {
  static const String httpDelete = 'DELETE';
  static const String httpGet = 'GET';
  static const String httpPut = 'PUT';
  static const String httpPost = 'POST';
}

sealed class FailureMessage {
  static const String deleteRequestMessage = 'deleteRequestMessage';
  static const String authTokenEmpty = 'authTokenEmpty';
  static const String putRequestMessage = 'putRequestMessage';
  static const String postRequestMessage = 'postRequestMessage';
  static const String getRequestMessage = 'getRequestMessage';
}

class API {
  final String? _authToken;
  final Dio _dio = Dio();

  API({required String? authToken}) : _authToken = authToken;

  FutureEither<Response> _makeRequest({
    required String url,
    required String method,
    dynamic body,
    bool requireAuth = true,
    String? token,
  }) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    if (token != null) {
      requestHeaders.addAll({"Authorization": "Bearer $token"});
    }
    if (requireAuth) {
      if ((token ?? '').isEmpty) {
        return Left(Failure(message: FailureMessage.authTokenEmpty));
      }
    }

    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: method);
      log('requireAuth : $requireAuth', name: method);
      if (body != null) {
        log('BODY : $body', name: method);
      }
    }

    try {
      final response = await _dio.request(
        url,
        data: body,
        options: Options(
          method: method,
          headers: requestHeaders,
        ),
      );

      if (AppConfig.logHttp) {
        log('RESPONSE : ${response.data}', name: method);
      }

      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
        message: _getErrorMessage(method),
        stackTrace: stktrc,
      ));
    }
  }

  FutureEither<Response> getRequest(
      {required String url,
      Map<String, dynamic>? queryParams,
      bool requireAuth = true,
      String? token}) async {
    return _makeRequest(
        url: url,
        method: LogLabel.httpGet,
        requireAuth: requireAuth,
        token: token);
  }

  FutureEither<Response> postRequest({
    required String url,
    dynamic body,
    bool requireAuth = true,
    required String token,
  }) async {
    return _makeRequest(
      url: url,
      method: LogLabel.httpPost,
      body: body,
      requireAuth: requireAuth,
      token: token,
    );
  }

  FutureEither<Response> putRequest({
    required String url,
    dynamic body,
    bool requireAuth = true,
    required String token,
  }) async {
    return _makeRequest(
      url: url,
      method: LogLabel.httpPut,
      body: body,
      requireAuth: requireAuth,
      token: token,
    );
  }

  FutureEither<Response> deleteRequest({
    required String url,
    dynamic body,
    bool requireAuth = true,
    required String token,
  }) async {
    return _makeRequest(
      url: url,
      method: LogLabel.httpDelete,
      body: body,
      requireAuth: requireAuth,
      token: token,
    );
  }

  String _getErrorMessage(String method) {
    switch (method) {
      case LogLabel.httpGet:
        return FailureMessage.getRequestMessage;
      case LogLabel.httpPost:
        return FailureMessage.postRequestMessage;
      case LogLabel.httpPut:
        return FailureMessage.putRequestMessage;
      case LogLabel.httpDelete:
        return FailureMessage.deleteRequestMessage;
      default:
        return 'Unknown error';
    }
  }
}
