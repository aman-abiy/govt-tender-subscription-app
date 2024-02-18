import 'package:intl/intl.dart';

class DateParser {
  static String getDate(int milliseconds) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return DateFormat("EE, d MMMM, yyyy").format(date.toUtc());
  }
}