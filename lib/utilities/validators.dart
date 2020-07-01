
/// This class is used to validate password, email, and name with the help of some regular expressions
/// and it also contains some error texts.

class Validators {
  /// The regular expression is used to make an internal validation rather than wasting requests on
  /// non-valid emails.
  ///
  static final RegExp _emailRegExp =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email) && email.endsWith('com');
  }

  static bool isValidPassword(String password) {
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasMinLength = password.length >= 8;
    return hasDigits && hasLowercase && hasUppercase & hasMinLength;
  }

  static final String errorPasswordText =
      'Password should be more than 8 digits and\ncontains upper, lower characters and numbers.';

  static final String errorNameText = 'Name should not be empty or have numbers.';
  static bool isValidName(String name) {
    bool hasNotDigits = !name.contains(RegExp(r'[0-9]'));
    return name.isNotEmpty && hasNotDigits;
  }
}
