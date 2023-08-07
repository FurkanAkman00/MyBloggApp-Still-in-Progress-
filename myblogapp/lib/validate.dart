class Validate {
  static String? username(String? value) {
    return (value?.isNotEmpty ?? false) ? null : Errors.empty;
  }

  static String? email(String? value) {
    if (value != null && value.isNotEmpty) {
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      return emailValid ? null : Errors.validEmail;
    }
    return Errors.empty;
  }

  static String? password(String? value) {
    if (value != null && value.isNotEmpty) {
      return value.length > 3 ? null : Errors.lowCharacter;
    }
    return Errors.empty;
  }

  static String? title(String? value) {
    if (value != null && value.isNotEmpty) {
      return value.length > 3 ? null : Errors.lowCharacter;
    }
    return Errors.empty;
  }

  static String? notEmpty(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    } else {
      return Errors.empty;
    }
  }
}

class Errors {
  static const String empty = "This area cannot be empty!";
  static const String lowCharacter = "Cannot be lower than 3 characters!";
  static const String validEmail = "Please enter a valid email";
}
