import 'package:dio/dio.dart';

Dio? _dio;

Dio dioInstance() {
  if (_dio == null) {
    final options = BaseOptions();
    _dio = Dio(options);
  }

  return _dio!;
}
