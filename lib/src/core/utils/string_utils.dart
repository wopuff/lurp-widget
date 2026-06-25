import 'package:flutter/material.dart';

extension PluralString on String {
  String plural([num count = 1, String? pluralForm]) {
    if (count == 1) {
      return this;
    } else {
      if (pluralForm != null) return pluralForm;
      return '${this}s'; // General plural form
    }
  }
}

extension CapitalizeString on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

bool isOnlyEmojis(String input) {
  final stripped = input.trim();
  if (stripped.isEmpty) return false;

  // ignore: valid_regexps
  final regex = RegExp(r'^\p{Extended_Pictographic}$', unicode: true);

  for (final rune in stripped.runes) {
    final char = String.fromCharCode(rune);
    if (!regex.hasMatch(char)) return false;
  }

  return true;
}

int graphemeLength(String input) {
  return input.characters.length;
}
