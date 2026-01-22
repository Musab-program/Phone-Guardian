import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_guardian/core/widgets/custom_text.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final String confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.onConfirm,
    this.cancelText,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,

      actions: [
        if (cancelText != null)
          TextButton(
            child: CustomText(text: cancelText!),
            onPressed: () {
              onCancel?.call();
              Get.back();
            },
          ),

        TextButton(
          onPressed: () {
            onConfirm();
            Get.back();
          },
          child: CustomText(text: confirmText),
        ),
      ],
    );
  }
}

void showConfirmationDialog({
  required String title,
  required Widget content,
  required VoidCallback onConfirm,
  String confirmText = 'تأكيد',
  String? cancelText,
  VoidCallback? onCancel,
  bool barrierDismissible = true,
}) {
  Get.dialog(
    CustomAlertDialog(
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
    ),
    barrierDismissible: barrierDismissible,
  );
}
