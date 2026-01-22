import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base_controllers/app_controller.dart';

class CustomTextField extends StatelessWidget {
  //All the properties that we can assign to TextField
  final TextEditingController? controllerText;
  final String? hintText;
  final String? labelText;
  final String? errorMessage;
  final bool encryptionText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validatorInput;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? borderColor;
  final bool? isFill;
  final Color? fillColor;

  const CustomTextField({
    super.key,
    this.controllerText,
    this.hintText,
    this.labelText,
    this.encryptionText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.validatorInput,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.borderColor,
    this.isFill,
    this.fillColor,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final AppController appController = Get.find();
      final bool isDarkMode = appController.isDarkMode.value;

      // final Color defaultBorderColor = isDarkMode ? AppThemes.dark.inputDecorationTheme.enabledBorder?.borderSide.color ?? Colors.grey : AppThemes.light.inputDecorationTheme.enabledBorder?.borderSide.color ?? Colors.grey;
      // final Color defaultFillColor = isDarkMode ? AppThemes.dark.inputDecorationTheme.fillColor ?? Colors.black : AppThemes.light.inputDecorationTheme.fillColor ?? Colors.white;
      // final Color defaultLabelColor = isDarkMode ? AppThemes.dark.inputDecorationTheme.hintStyle?.color ?? Colors.grey : AppThemes.light.inputDecorationTheme.hintStyle?.color ?? Colors.grey;

      return TextFormField(
        controller: controllerText,
        obscureText: encryptionText,
        keyboardType: keyboardType,
        validator: validatorInput,
        style: TextStyle(color: textColor),

        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          hintStyle: TextStyle(color: hintColor),
          labelStyle: TextStyle(color: labelColor),
          errorText: errorMessage,

          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          filled: isFill ?? true,
          fillColor: fillColor,
        ),
      );
    });
  }
}
