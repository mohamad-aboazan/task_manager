class Validation {
  static String? passwordValidation(String value) {
    if (value.isEmpty) {
      return "value must be not empty";
    } else if (value.length < 5) {
      return "Password must be more than 5 charachter";
    }
    return null;
  }

  static isEmptyValidation(value) {
    if (value.isEmpty) {
      return "must be not empty";
    }
  }

  static String? confirmPasswordValidation(value, password) {
    if (value.isEmpty) {
      return "value must be not empty";
    }
    if (value != password) {
      return "your password not matched with confirm password";
    }
    return null;
  }

  static String? email(String value) {
    final RegExp urlExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isEmpty) {
      return "value must be not empty";
    } else if (!urlExp.hasMatch(value)) {
      return "your email not valid";
    }
    return null;
  }

  static String? userNameValidation(String value) {
    if (value.isEmpty) {
      return "your password not matched with confirm password";
    }
    if (value.length < 5) {
      return "Password must be more than 5 charachter";
    }
    return null;
  }
}
