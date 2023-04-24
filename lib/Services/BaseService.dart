import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../Interceptors/index.dart';

class BaseService {
  BaseService();

  Dio dioInterceptor() {
    Dio dio = Dio();
    dio.interceptors.add(DioInterceptor());
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =   
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
    return dio;
  }
}
