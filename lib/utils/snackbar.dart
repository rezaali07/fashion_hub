import 'package:fashion_hub/utils/colors.dart';
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, {required String text, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: AppColor.kPrimary,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
  ));
}
