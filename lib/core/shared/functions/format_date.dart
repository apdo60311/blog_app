import 'package:intl/intl.dart';

String formatDate(DateTime dateTime, [String format = 'd MMM, yyyy']) {
  try {
    return DateFormat(format).format(dateTime);
  } catch (e) {
    return dateTime.toString();
  }
}
