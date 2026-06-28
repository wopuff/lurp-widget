import 'package:lurp/src/core/utils/string_utils.dart';

class DateFormat {
  static String dateToWords(
    DateTime date, {
    endWithAgo = true,
    bool shortened = false,
    int maxWeeks = 8,
    int maxMonths = 24,
  }) {
    var timeDifferenceInMilliseconds =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    var ending = endWithAgo ? ' ago' : '';

    var seconds = timeDifferenceInMilliseconds ~/ 1000;
    if (seconds < 10) {
      return 'just now';
    }
    if (seconds < 60) {
      return _dateToWordsFormat(seconds, 's', 'second', shortened, ending);
    }
    final minutes = (seconds / 60).round();
    if (minutes < 60) {
      return _dateToWordsFormat(minutes, 'm', 'minute', shortened, ending);
    }
    var hours = (minutes / 60).round();
    if (hours < 24) {
      return _dateToWordsFormat(hours, 'h', 'hour', shortened, ending);
    }
    var days = (hours / 24).round();
    if (days < 7) {
      return _dateToWordsFormat(days, 'd', 'day', shortened, ending);
    }
    var weeks = (days / 7).round();
    if (weeks < maxWeeks) {
      return _dateToWordsFormat(weeks, 'w', 'week', shortened, ending);
    }
    var months = (days / 30).round();
    if (months < maxMonths) {
      return _dateToWordsFormat(months, 'mo', 'month', shortened, ending);
    }
    var years = (months / 12).round();
    return _dateToWordsFormat(years, 'y', 'year', shortened, ending);
  }

  static String _dateToWordsFormat(
    int count,
    String shortUnit,
    String longUnit,
    bool isShortened,
    String ending,
  ) {
    var addedSpace = isShortened ? '' : ' ';
    final unit = isShortened ? shortUnit : longUnit.plural(count);
    return '$count$addedSpace$unit$ending';
  }

  static String formatDate(DateTime date) {
    var year = date.year;
    var month = date.month;
    var day = date.day;

    var formattedDate = '$year/';

    if (month < 10) formattedDate += '0';
    formattedDate += '$month/';

    if (day < 10) formattedDate += '0';
    formattedDate += '$day';

    return formattedDate;
  }

  static String dateToTime(DateTime time, {bool showSeconds = false}) {
    // Convert the input time to CET
    var cetTime = time.toUtc().add(const Duration(hours: 1));
    if (_isDST(cetTime)) {
      cetTime = cetTime.add(const Duration(hours: 1));
    }

    // Format the hours, minutes, and optionally the seconds
    var formattedTime = '';
    formattedTime += cetTime.hour.toString().padLeft(2, '0');
    formattedTime += ':';
    formattedTime += cetTime.minute.toString().padLeft(2, '0');

    if (showSeconds) {
      formattedTime += ':';
      formattedTime += cetTime.second.toString().padLeft(2, '0');
    }

    formattedTime += ' CET';

    return formattedTime;
  }

  static bool _isDST(DateTime dateTime) {
    // Simple DST check for CET/CEST
    // DST starts on the last Sunday of March and ends on the last Sunday of October
    final int year = dateTime.year;
    final DateTime lastSundayOfMarch = DateTime(
      year,
      3,
      31,
    ).subtract(Duration(days: DateTime(year, 3, 31).weekday % 7));
    final DateTime lastSundayOfOctober = DateTime(
      year,
      10,
      31,
    ).subtract(Duration(days: DateTime(year, 10, 31).weekday % 7));

    return dateTime.isAfter(lastSundayOfMarch) &&
        dateTime.isBefore(lastSundayOfOctober);
  }
}
