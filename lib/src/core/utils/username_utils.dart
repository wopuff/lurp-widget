import 'package:lurp/src/core/entities/return_data.dart';
import 'package:lurp/src/users/domain/entities/user.dart';

class UsernameFormatUtils {
  static const _minLength = User.minUsernameLength;
  static const _maxLength = User.maxUsernameLength;

  static ReturnData validate(String username) {
    // 1. Length 4–23
    if (username.length < _minLength || username.length > _maxLength) {
      return ReturnData(
        isError: true,
        data: false,
        title: 'Invalid length',
        body:
            'Username must be between $_minLength and $_maxLength characters.',
      );
    }

    // 2. Must start with a letter or number
    if (!RegExp(r'^[a-zA-Z0-9]').hasMatch(username)) {
      return ReturnData(
        isError: true,
        data: false,
        title: 'Invalid starting character',
        body: 'Username must start with a letter or number.',
      );
    }

    // 3. Cannot end with space or period (underscore allowed)
    if (RegExp(r'[ .]$').hasMatch(username)) {
      return ReturnData(
        isError: true,
        data: false,
        title: 'Invalid ending character',
        body: 'Username cannot end with a space or period.',
      );
    }

    // 4. Allowed characters
    if (!RegExp(r'^[a-zA-Z0-9 ._]+$').hasMatch(username)) {
      return ReturnData(
        isError: true,
        data: false,
        title: 'Invalid characters',
        body: 'Username contains invalid characters.',
      );
    }

    // 5. No consecutive spaces, periods, or underscores
    if (RegExp(r'(  |\.\.|__)').hasMatch(username)) {
      return ReturnData(
        isError: true,
        data: false,
        title: 'Invalid formatting',
        body: 'No consecutive spaces, periods, or underscores.',
      );
    }

    // 6. Special characters must connect to at least one letter/number
    const specials = [' ', '.', '_'];

    for (int i = 0; i < username.length; i++) {
      final char = username[i];

      if (!specials.contains(char)) continue;

      final prev = i > 0 ? username[i - 1] : null;
      final next = i < username.length - 1 ? username[i + 1] : null;

      final prevIsAlNum = prev != null && RegExp(r'[a-zA-Z0-9]').hasMatch(prev);
      final nextIsAlNum = next != null && RegExp(r'[a-zA-Z0-9]').hasMatch(next);

      // Underscore at end IS allowed → skip special case
      if (char == '_' && i == username.length - 1) continue;

      // Otherwise must have at least one adjacent alphanumeric character
      if (!prevIsAlNum && !nextIsAlNum) {
        return ReturnData(
          isError: true,
          data: false,
          title: 'Invalid formatting',
          body:
              'Special characters must connect to at least one letter or number.',
        );
      }
    }

    return ReturnData(isError: false, data: true, body: 'Username is valid.');
  }
}
