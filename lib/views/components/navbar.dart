import 'package:flutter/material.dart';
import 'package:food_facts/common/constants.dart';

AppBar headerNav(
  BuildContext context, {
  String? title,
  Widget? action,
}) {
  return AppBar(
    title: Text(title ?? ''),
    actions: [
      action ?? emptyWidget,
      horizontalMargin8,
    ],
  );
}
