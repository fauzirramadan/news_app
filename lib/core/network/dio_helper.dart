import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHandler {
  Dio dio = Dio()
    ..interceptors.add(InterceptorsWrapper(
      onResponse: (Response res, handler) {
        if (kDebugMode) {
          print("Response: ${{
            "method": res.requestOptions.method,
            "url": res.requestOptions.baseUrl + res.requestOptions.path,
            "body": res.data,
          }}");
        }
        handler.next(res);
      },
      onRequest: (RequestOptions req, handler) {
        log("Request: ${{
          "method": req.method,
          "url": req.baseUrl + req.path,
          "data": req.data is FormData ? req.data.fields : req.data,
          "params": req.queryParameters
        }}");
        handler.next(req);
      },
      onError: (DioError err, handler) {
        log("Error: ${err.response?.statusCode} - ${err.requestOptions.baseUrl}${err.requestOptions.path} - ${err.response?.data}");
        handler.next(err);
      },
    ));
}

Dio dio = DioHandler().dio;
