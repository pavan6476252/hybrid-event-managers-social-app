class Error {
  String msg;
  int? statusCode;
  Error({
    required this.msg,
    required this.statusCode,
  });
}

class HTTPHandler<T> {
  T? data;
  Error? error;
  HTTPHandler({
    this.data,
    this.error,
  });
}
