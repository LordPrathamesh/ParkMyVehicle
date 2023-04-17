import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Do something before the request is sent
    debugPrint("===Interceptor Call on Request==-");
    debugPrint("===Interceptor Call on Request==-${options.path}");
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // Do something with the response data
    debugPrint("===Interceptor Call on Response===");
    debugPrint("===Interceptor Call on Response==-${response.data}");
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError error, ErrorInterceptorHandler handler) async {
    // Do something with the error
    return super.onError(error, handler);
  }
}
