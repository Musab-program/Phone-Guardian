import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base_controllers/app_controller.dart';
import '../utils/themes.dart';

class CustomText extends StatelessWidget {
  //All the properties that we can assign to Text
  final String text;
  final Color? textColor;
  final double? textFontSize;
  final TextAlign? textAlignment;
  final FontWeight? textFontWeight;
  final FontStyle? textFontStyle;
  final int? maxLines;
  final TextOverflow? textOverflow;

  const CustomText({
    super.key,
    required this.text,
    this.textColor,
    this.textFontSize,
    this.textAlignment,
    this.textFontWeight,
    this.textFontStyle,
    this.maxLines,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find();

    return Obx(() {
      final bool isDarkMode = appController.isDarkMode.value;
      final Color defaultTextColor = isDarkMode
          ? AppThemes.dark.colorScheme.onSurface
          : AppThemes.light.colorScheme.onSurface;

      return Text(
        text,
        textAlign: textAlignment,
        maxLines: maxLines,
        overflow: textOverflow,
        style: TextStyle(
          fontStyle: textFontStyle ?? FontStyle.normal,
          fontWeight: textFontWeight ?? FontWeight.normal,
          fontSize: textFontSize ?? 16,
          color: textColor ?? defaultTextColor,
        ),
      );
    });
  }
}
