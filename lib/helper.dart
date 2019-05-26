import 'package:intl/intl.dart';
import 'package:trakref_app/constants.dart';

class Helper {
  static String getFromStringDate(String trakrefStandardFormattedDate, String endFormat) {
    try {
      DateTime trakrefStandardDateTime = DateFormat(kShortTimeDateFormat).parse(trakrefStandardFormattedDate);
      return DateFormat(endFormat)
          .format(trakrefStandardDateTime);
    }
    catch (error) {
      return null;
    }
  }

  static String getReadableDate(String trakrefStandardFormattedDate) {
    return getFromStringDate(trakrefStandardFormattedDate, kShortReadableDateFormat);
  }

  static String getShortDate(String trakrefStandardFormattedDate) {
    return getFromStringDate(trakrefStandardFormattedDate, kShortDateFormat);
  }
}