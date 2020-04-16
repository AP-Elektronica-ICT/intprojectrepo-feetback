import 'package:intl/intl.dart';

class DateUtils {
  static final DateFormat _dayOfMonthFormat = new DateFormat("dd");
  static final DateFormat _monthNameShortFormat = new DateFormat("MMM");
  static final DateFormat _fullDateTimeFormat = new DateFormat("dd-MM-yyyy – hh:mm");

  static String dayOfMonth(DateTime d) => _dayOfMonthFormat.format(d);
  static String monthNameShort(DateTime d) => _monthNameShortFormat.format(d) + ".";
  static String fullDateTime(DateTime d) => _fullDateTimeFormat.format(d);
}