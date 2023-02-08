import 'package:intl/intl.dart';

class DateFormatUtils {
  static final _simpleTime = DateFormat("yyyy-MM-dd");

  static String toSimpleTime(DateTime date) {
    try {
      return _simpleTime.format(date);
    } catch (e) {
      return "-";
    }
  }
}
