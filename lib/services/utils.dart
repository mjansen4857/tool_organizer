class Utils {
  static String formatDate(DateTime date) {
    return date.month.toString() +
        '/' +
        date.day.toString() +
        '/' +
        date.year.toString();
  }
}
