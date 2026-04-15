import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/styles/colors.dart';

abstract class TextStyles {
  static const TextStyle headline = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle body = TextStyle(fontSize: 16);
  static const TextStyle small = TextStyle(fontSize: 14);
  static const TextStyle caption1 = TextStyle(
    fontSize: 12,
    color: AppColors.greyColor,
  );
}
