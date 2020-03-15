import 'package:intl/intl.dart';

class DateUtils {
  static final DateFormat _dayOfMonthFormat = new DateFormat("dd");
  static final DateFormat _monthNameShortFormat = new DateFormat("MMM");

  static String dayOfMonth(DateTime d) => _dayOfMonthFormat.format(d);
  static String monthNameShort(DateTime d) => _monthNameShortFormat.format(d) + ".";
}