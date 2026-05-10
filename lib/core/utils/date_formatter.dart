import "package:intl/intl.dart";

abstract class DateFormatter {
  static String toDisplayDate(DateTime date) => DateFormat("dd MMM yyyy").format(date);

  static String toDisplayDateTime(DateTime date) => DateFormat("dd MMM yyyy, HH:mm").format(date);

  static String toDisplayTime(String time) => time;

  static String toApiDate(DateTime date) => DateFormat("yyyy-MM-dd").format(date);

  static String toApiDateTime(DateTime date) => date.toIso8601String();

  static DateTime fromApiDate(String date) => DateTime.parse(date);

  static String timeFromDateTime(DateTime date) => DateFormat("HH:mm").format(date);
}
