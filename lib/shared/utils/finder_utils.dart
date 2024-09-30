// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_accessibility/shared/utils/semantics_utils.dart';
import 'package:flutter_test/flutter_test.dart';

class FinderUtils {
  static Finder bySemanticsLabel(
    CommonFinders find, {
    required String label,
    String? onTapHint,
    String? hint,
    bool? hidden,
    bool? button,
    bool? explicitChildNodes,
  }) =>
      find.byWidgetPredicate(
        (Widget widget) {
          final bool validSemantics = widget is Semantics &&
              widget.properties.label == label &&
              widget.properties.hintOverrides?.onTapHint == onTapHint &&
              widget.properties.hint == hint &&
              widget.properties.hidden == hidden &&
              widget.properties.button == button;

          if (explicitChildNodes == null) return validSemantics;

          return validSemantics && widget.explicitChildNodes == explicitChildNodes;
        },
      );

  static Finder bySemanticsButton(CommonFinders find, {required String label, String? onPressedHint, String? overrideOnPressedHint, bool isButton = true}) =>
      find.byWidgetPredicate((Widget widget) =>
          widget is Semantics &&
          widget.properties.button == true &&
          widget.properties.label == label &&
          widget.properties.hint == ((!isButton && onPressedHint == null) ? '' : defaultHint(onPressedHint, overrideOnPressedHint, isButton)));

  static Finder byMergedSemanticsLabel(
    CommonFinders find,
    WidgetTester tester, {
    required List<String> mergedLabels,
  }) =>
      find.byWidgetPredicate((Widget widget) {
        if (widget is! MergeSemantics) {
          return false;
        }

        final String expectedLabel = mergedLabels.join('\n').replaceAll('\n', '\\n').replaceAll('\t', '\\t');
        SemanticsNode mergeSemantics = tester.getSemantics(find.byWidget(widget));
        String? nodeLabel = mergeSemantics.toDiagnosticsNode().toTimelineArguments()?['label']?.replaceAll('"', '');

        return nodeLabel == expectedLabel;
      });

  static Finder byAttributedSemanticsLabel(
    CommonFinders find, {
    required String label,
    required List<String> words,
    bool? explicitChildNodes,
  }) =>
      find.byWidgetPredicate(
        (Widget widget) {
          final List<StringAttribute> wordsList = SemanticsUtils.createAttributesList(label, words);
          bool validSemantics;

          if (wordsList.isEmpty) {
            validSemantics = widget is Semantics &&
                widget.excludeSemantics == true &&
                widget.properties.attributedLabel != null &&
                widget.properties.attributedLabel!.string == label &&
                widget.properties.attributedLabel?.attributes.isEmpty == true;
          } else {
            validSemantics = widget is Semantics &&
                widget.excludeSemantics == true &&
                widget.properties.attributedLabel != null &&
                widget.properties.attributedLabel!.string == label &&
                widget.properties.attributedLabel?.attributes.length == wordsList.length;
          }

          return validSemantics;
        },
      );

  static String defaultHint(String? onPressedHint, String? overrideOnPressedHint, bool isButton) =>
      ' ${isButton ? 'botão.' : ''} ${overrideOnPressedHint ?? 'Toque duas vezes para ${onPressedHint ?? 'ativar'}'}';

  String defaultOnPressedHint(String? hint, {String? overrideOnPressedHint, required bool isButton}) {
    if (!isButton && hint == null) return '';

    final String actionLabel = hint ?? 'ativar';
    final String hintText = overrideOnPressedHint ?? 'Toque duas vezes para $actionLabel';

    return ' ${isButton ? 'botão.' : ''} $hintText';
  }
}
