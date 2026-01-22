import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ble_controller.dart';
import '../constants/app_color.dart';

class ScanningDialog extends StatefulWidget {
  const ScanningDialog({Key? key}) : super(key: key);

  @override
  State<ScanningDialog> createState() => _ScanningDialogState();
}

class _ScanningDialogState extends State<ScanningDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BleController controller = Get.find<BleController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false, // Prevent closing by back button
      child: Dialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Radar Animation
              Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryColor.withOpacity(
                              1 - _animationController.value,
                            ),
                            width: 4 + (4 * _animationController.value),
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor.withOpacity(
                            0.1 * (1 - _animationController.value),
                          ),
                        ),
                      );
                    },
                  ),
                  const Icon(
                    Icons.radar_rounded,
                    size: 40,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Status Text
              Obx(
                () => Text(
                  controller.statusMessage.value, // "Searching..." or "Found!"
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Cancel Button
              TextButton(
                onPressed: () {
                  Get.back(); // Close dialog
                  controller.stopScan();
                },
                child: Text(
                  "cancel".tr,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
