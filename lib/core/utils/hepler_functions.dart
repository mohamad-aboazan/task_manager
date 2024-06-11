///======================================================================================================
/// A utility class for common helper functions.
///======================================================================================================

abstract class HelperFunctions {
  /// Checks if two lists of strings are equal.
  static bool listEquals(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) {
      return false;
    }
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }
    return true;
  }
}
