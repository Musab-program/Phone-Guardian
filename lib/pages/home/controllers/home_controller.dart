import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../../../core/controllers/ble_controller.dart';
import '../../../core/services/preference_Service.dart';

class HomeController extends GetxController {
  final BleController bleController = Get.find<BleController>();

  final PreferenceService _prefs = Get.find<PreferenceService>();

  // Reactive State
  final RxBool isConnected = false.obs;
  final RxDouble distance = 3.0.obs;
  final RxInt vibrationDuration = 3.obs; // 1, 2, or 3 seconds
  final RxBool isContinuousVibration =
      true.obs; // True = Continuous, False = Intermittent
  final RxBool isServiceActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings(); // Load saved data

    // Sync connection status
    bleController.isDeviceConnected.listen((connected) {
      isConnected.value = connected;
      if (connected) {
        _syncSettingsToDevice(); // Sync settings when connected
      }
    });

    // Listen to Bluetooth State to stop service
    FlutterBluePlus.adapterState.listen((state) {
      if (state != BluetoothAdapterState.on) {
        if (isServiceActive.value) {
          isServiceActive.value = false;
          _prefs.setServiceActive(false);
          // UI will update automatically
        }
      }
    });
  }

  void _loadSettings() {
    distance.value = _prefs.getDistance().toDouble();
    vibrationDuration.value = _prefs.getVibrationDuration();
    isContinuousVibration.value = _prefs.getVibrationPattern();
    isServiceActive.value = _prefs.getServiceActive();
  }

  void _syncSettingsToDevice() {
    // Send all current settings to ESP32
    Future.delayed(const Duration(milliseconds: 500), () {
      bleController.setDistance(distance.value.toInt());
      bleController.setVibrationDuration(vibrationDuration.value);
      bleController.setVibrationPattern(isContinuousVibration.value);
      bleController.setServiceState(
        isServiceActive.value,
      ); // Wait, setServiceState usage
    });
  }

  void toggleConnection() {
    // 1. Enforce Service ON
    if (!isServiceActive.value) {
      toggleService(); // Use existing toggle to save pref, update BLE, and update UI
    }

    // 2. Connect if not connected
    if (!isConnected.value) {
      bleController.startAutoConnect(manual: true);
    }
  }

  void updateDistance(double value) {
    distance.value = value;
    _prefs.setDistance(value.toInt());
    bleController.setDistance(value.toInt());
  }

  void setVibrationDuration(int duration) {
    vibrationDuration.value = duration;
    _prefs.setVibrationDuration(duration);
    bleController.setVibrationDuration(duration);
  }

  void setVibrationPattern(bool isContinuous) {
    isContinuousVibration.value = isContinuous;
    _prefs.setVibrationPattern(isContinuous);
    bleController.setVibrationPattern(isContinuous);
  }

  void toggleService() {
    isServiceActive.value = !isServiceActive.value;
    _prefs.setServiceActive(isServiceActive.value);
    bleController.setServiceState(isServiceActive.value);
  }
}
