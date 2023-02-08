import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/core/helper/failure.dart';
import 'package:news_app/core/network/api.dart';
import 'package:news_app/core/network/dio_helper.dart';
import 'package:news_app/core/response/res_get_news.dart';

import '../helper/either.dart';

class GeneralRepo {
  Future<Either<Failure, ResGetNews>> fetchAllNews({
    String? query,
    String? fromDate,
    String? toDate,
  }) async {
    try {
      Response res = await dio
          .get(Api.allNewsUrl, options: Api.authorization, queryParameters: {
        "q": query,
        "language": "id",
        "fromDate": fromDate,
        "toDate": toDate,
        "pageSize": 50
      });
      return Either.success(ResGetNews.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        log(st.toString());
      }
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, ResGetNews>> fetchNewsPerCategory({
    String? fromDate,
    String? toDate,
    String? category,
  }) async {
    try {
      Response res = await dio.get(Api.perCatNewsUrl,
          options: Api.authorization,
          queryParameters: {
            "country": "id",
            "category": category,
            "pageSize": 50
          });
      return Either.success(ResGetNews.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        log(st.toString());
      }
      return Either.error(Failure(e.toString()));
    }
  }
}
