class ConvertUtils{
  static bool isNumber(String input) {
    return int.tryParse(input) != null || double.tryParse(input) != null;
  }

  static bool isText(String input) {
    return !isNumber(input);
  }
}