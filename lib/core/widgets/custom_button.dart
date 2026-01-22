import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base_controllers/app_controller.dart';
import '../utils/themes.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  //All the properties that we can assign to button
  final String? buttonText;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final double? textFontSize;
  final FontWeight? textFontWeight;
  final FontStyle? textFontStyle;
  final double? buttonWidth;
  final double? buttonHeight;
  final IconData? buttonIcon;
  final double? buttonRadius;

  const CustomButton({
    super.key,
    this.buttonText,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.buttonIcon,
    this.buttonRadius,
    this.textFontSize,
    this.textFontWeight,
    this.textFontStyle,
  });

  @override
  Widget build(BuildContext context) {
    //The widget that we will return
    return Obx(() {
      final AppController appController = Get.find();
      final bool isDarkMode = appController.isDarkMode.value;
      final Color defaultButtonColor = isDarkMode
          ? AppThemes.dark.colorScheme.primary
          : AppThemes.light.colorScheme.primary;
      final Color defaultTextColor = isDarkMode
          ? AppThemes.dark.colorScheme.onPrimary
          : AppThemes.light.colorScheme.onPrimary;

      return SizedBox(
        width: buttonWidth ?? double.infinity,
        height: buttonHeight ?? 50.0,
        //The button
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor ?? defaultButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius ?? 10.0),
            ),
            elevation: 0,
          ),
          child: _buildButtonChild(defaultTextColor),
        ),
      );
    });
  }

  Widget _buildButtonChild(Color defaultTextColor) {
    //there is an icon and text ,so we display both
    if (buttonText != null && buttonIcon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(buttonIcon, color: textColor ?? defaultTextColor),
          const SizedBox(width: 8),
          CustomText(
            text: buttonText!,
            textFontSize: textFontSize,
            textFontWeight: textFontWeight,
            textFontStyle: textFontStyle,
            textColor: textColor ?? defaultTextColor,
          ),
        ],
      );
    }
    // if there is an icon just we display it
    else if (buttonIcon != null) {
      return Icon(buttonIcon, color: textColor ?? defaultTextColor);
    }
    // if there is an text just we display it
    else {
      return CustomText(
        text: buttonText!,
        textFontSize: textFontSize,
        textFontWeight: textFontWeight,
        textFontStyle: textFontStyle,
        textColor: textColor ?? defaultTextColor,
      );
    }
  }
}
