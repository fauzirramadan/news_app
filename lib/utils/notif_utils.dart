import 'package:flutter/material.dart';
import 'package:news_app/app/app.dart';

class NotifUtils {
  static void showSnackbar(String message,
      {Color? backgroundColor, SnackBarAction? action}) {
    notifKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        action: action,
        content: Text(
          message,
        ),
      ),
    );
  }
}
