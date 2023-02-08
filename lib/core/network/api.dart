import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static final authorization =
      Options(headers: {"Authorization": "Bearer ${dotenv.env['Api_Key']}"});
}
