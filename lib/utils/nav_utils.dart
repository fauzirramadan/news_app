import 'package:flutter/material.dart';

import '../app/app.dart';

class Nav {
  static Future<dynamic> to(Widget page) async {
    return await navKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }

  static Future<dynamic> toAll(Widget page) async {
    return await navKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
      (_) => false,
    );
  }

  static Future<dynamic> back({dynamic data}) async {
    return navKey.currentState?.pop(data);
  }
}
