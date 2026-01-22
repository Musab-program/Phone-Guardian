import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_color.dart';
import '../controllers/home_controller.dart';

class ProtectionSettingsCard extends StatelessWidget {
  const ProtectionSettingsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isDark ? AppColors.accentColor : AppColors.primaryColor;
    final textColor = isDark ? Colors.white70 : Colors.grey;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "protectionSettings".tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: controller.isConnected.value
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: controller.isConnected.value
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bluetooth,
                        size: 14,
                        color: controller.isConnected.value
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        controller.isConnected.value
                            ? "Connected"
                            : "Disconnected",
                        style: TextStyle(
                          fontSize: 12,
                          color: controller.isConnected.value
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Distance Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "distance".tr,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Obx(
                () => Text(
                  "${controller.distance.value.toInt()}m",
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          ),
          Obx(
            () => Slider(
              value: controller.distance.value,
              min: 1,
              max: 5,
              divisions: 4,
              label: "${controller.distance.value.toInt()}m",
              onChanged: controller.updateDistance,
              activeColor: activeColor,
            ),
          ),
          const SizedBox(height: 10),

          // Vibration Duration
          Text(
            "vibrationDuration".tr,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [1, 2, 3].map((duration) {
                final isSelected =
                    controller.vibrationDuration.value == duration;
                return Expanded(
                  // Wrap in Expanded to fix overflow
                  child: InkWell(
                    onTap: () => controller.setVibrationDuration(duration),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ), // Add margin for spacing
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? activeColor.withOpacity(0.1)
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? activeColor
                              : (isDark
                                    ? Colors.white24
                                    : Colors.grey.shade300),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Center content
                        children: [
                          if (isSelected)
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 5,
                              ), // LTR padding
                              child: Icon(
                                Icons.check_circle,
                                size: 16,
                                color: activeColor,
                              ),
                            ),
                          Text(
                            "$duration ${'seconds'.tr}",
                            style: TextStyle(
                              color: isSelected ? activeColor : textColor,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 12, // Reduce font size slightly
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          // Vibration Pattern
          Text(
            "vibrationPattern".tr,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text(
                      "continuous".tr,
                      style: const TextStyle(fontSize: 14),
                    ),
                    value: true,
                    groupValue: controller.isContinuousVibration.value,
                    activeColor: activeColor,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) => controller.setVibrationPattern(true),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text(
                      "intermittent".tr,
                      style: const TextStyle(fontSize: 14),
                    ),
                    value: false,
                    groupValue: controller.isContinuousVibration.value,
                    activeColor: activeColor,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) => controller.setVibrationPattern(false),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Service Toggle Button
          Text(
            "serviceStatus".tr,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 15),
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: controller.toggleService,
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isServiceActive.value
                      ? Colors.green
                      : Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                ),
                child: Text(
                  controller.isServiceActive.value
                      ? "serviceOn".tr
                      : "serviceOff".tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Obx(
              () => Text(
                controller.isServiceActive.value
                    ? "serviceRunning".tr
                    : "serviceStopped".tr,
                style: TextStyle(
                  color: controller.isServiceActive.value
                      ? Colors.green
                      : textColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
