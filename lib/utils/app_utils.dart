import 'package:intl/intl.dart';

class AppUtils {

  static String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat("MMM dd, yyyy • hh:mm a").format(dateTime.toLocal());
  }


}