import 'dart:ui';
import 'package:flutter/semantics.dart';

class SemanticsUtils {
  static AttributedString spellOutLabel({required String label, required List<String> wordsToSpell}) {
    return AttributedString(
      label,
      attributes: createAttributesList(label, wordsToSpell),
    );
  }

  static List<StringAttribute> createAttributesList(String label, List<String> words) {
    List<StringAttribute> attributes = <StringAttribute>[];
    final String formattedLabel = label.toLowerCase();

    for (String word in words) {
      final int start = formattedLabel.indexOf(word.toLowerCase());
      if (start == -1) continue;

      final int end = (start + word.length) - 1;

      attributes.add(SpellOutStringAttribute(
        range: TextRange(start: start, end: end),
      ));
    }
    return attributes;
  }
}
