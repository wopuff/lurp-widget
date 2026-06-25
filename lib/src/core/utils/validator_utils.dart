class ValidatorUtils {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
    );
    return emailRegex.hasMatch(email.trim());
  }

  static bool isValidLoginCode(String code) {
    code = code.trim();
    return code.length > 5 && code.length < 9;
  }

  static bool isValidName(String name) {
    return name.trim().isNotEmpty;
  }
}
