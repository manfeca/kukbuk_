class Utility {
  // =================================
  // Convert firt letter to uppercase
  // =================================
  static String firstToUpper(String ingredient) {
    var temp = ingredient.substring(0, 1).toUpperCase();
    var temp2 = ingredient.substring(1);
    return ingredient = ingredient.replaceRange(0, null, temp) + temp2;
  }

  // =========================================================
  // CHECK IS THE STRING OF A "ShowDialog" IS BLANK OR NULL
  // ========================================================#

  static bool isBlankString(String? value) {
    return (value == null || value.trim().isEmpty);
  }
}
