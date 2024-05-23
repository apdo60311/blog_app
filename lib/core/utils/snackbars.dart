import 'package:blog_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

/// Shows a snackbar with the given `text` and optional [backgroundColor].
///
/// The `backgroundColor` defaults to ```AppColors.gradient1``` if not provided.

void showSnackBar(BuildContext context, String text,
    [Color backgroundColor = AppColors.gradient1]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: backgroundColor,
    ),
  );
}
