import 'dart:math';

import 'package:flutter/material.dart';

class FormatUtils {
  static String shortenNumber(int i) {
    double newNumber;
    String prefix;
    int factor = 1000;

    // do nothing, just return number
    if (i < factor) {
      return i.toString();
    }
    // number is too large - shorten with prefix
    else if (i < pow(factor, 2)) {
      newNumber = i / factor;
      prefix = 'k';
    } else if (i < pow(factor, 3)) {
      newNumber = i / pow(factor, 2);
      prefix = 'M';
    } else if (i < pow(factor, 4)) {
      newNumber = i / pow(factor, 3);
      prefix = 'G';
    }
    // take for granted that the number won't be bigger than 999 trillion
    else {
      newNumber = i / pow(factor, 4);
      prefix = 'T';
    }

    // Format the number to remove decimals for large numbers like 1G, 999T, etc.
    String formattedNumber = newNumber.toStringAsFixed(1);
    if (formattedNumber.endsWith('.0')) {
      formattedNumber = newNumber.toInt().toString(); // Remove .0 for integers
    }

    // return formatted number with prefix (e.g. 72k)
    return '$formattedNumber$prefix';
  }

  static String indexToWord(int i, {bool lowercase = false}) {
    String output = 'none';
    switch (i) {
      case 0:
        output = 'First';
        break;
      case 1:
        output = 'Second';
        break;
      case 2:
        output = 'Third';
        break;
      case 3:
        output = 'Fourth';
        break;
      case 4:
        output = 'Fifth';
        break;
      case 5:
        output = 'Sixth';
        break;
      case 6:
        output = 'Seventh';
        break;
      case 7:
        output = 'Eighth';
        break;
      case 8:
        output = 'Ninth';
        break;
      case 9:
        output = 'Tenth';
        break;
      default:
        output = '${i + 1}th';
    }

    if (lowercase) output = output.toLowerCase();

    return output;
  }

  static void modifyTextInput(
    TextEditingController controller,
    String newText,
  ) {
    final newSelection = controller.selection.copyWith(
      baseOffset: newText.length,
      extentOffset: newText.length,
    );

    controller.value = TextEditingValue(
      text: newText,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }

  static String cleanException(Object e) {
    if ('$e'.length < 11) return '$e';
    if ('$e'.substring(0, 11) == 'Exception: ') return '$e'.substring(11);
    return '$e';
  }

  static String cleanText(String s) {
    String trimmedText = s.trim();

    // Replace three or more consecutive line breaks with two line breaks.
    return trimmedText.replaceAll(RegExp(r'\n{3,}'), '\n\n');
  }
}
