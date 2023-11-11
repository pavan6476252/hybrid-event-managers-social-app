class HelperFunctions {
  static String countToKsConvertion(int count) {
    if (count > 999) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    else {
      return count.toString();
    }
  }
}
