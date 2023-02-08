import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static final authorization =
      Options(headers: {"Authorization": "${dotenv.env['Api_Key']}"});

  static const String baseUrl = "https://newsapi.org/v2";
  static const String allNewsUrl = "$baseUrl/everything";
  static const String perCatNewsUrl = "$baseUrl/top-headlines";
}
