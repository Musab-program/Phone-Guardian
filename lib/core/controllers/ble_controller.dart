import 'dart:async';
import 'dart:math' as math; // Fix 1: Lowercase prefix
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/scanning_dialog.dart';

class BleController extends GetxController {
  // Target Device Name
  static const String targetDeviceName = "ESP32";

  // RSSI & Safety Constants
  static const int _smaSize = 10; // Matched to ESP32 numReadings
  final List<int> _rssiBuffer = [];
  int _farCount = 0;
  static const int _farThreshold = 3;

  // State
  final RxInt currentThreshold = (-75).obs; // Dynamic Threshold

  // State
  final RxBool isScanning = false.obs;
  final Rx<BluetoothDevice?> connectedDevice = Rx<BluetoothDevice?>(null);
  final RxBool isDeviceConnected = false.obs;
  final RxString statusMessage = "Disconnected".obs;

  // Smart Observables
  final RxDouble estimatedDistance = 0.0.obs;
  final RxBool isSafe = true.obs;
  Timer? _rssiTimer;

  BluetoothCharacteristic? writeCharacteristic;
  StreamSubscription? _scanSubscription;
  StreamSubscription? _connectionSubscription;

  @override
  void onInit() {
    super.onInit();
    // Do not auto-connect on init as per user request

    // Listen for Bluetooth Adapter State changes
    FlutterBluePlus.adapterState.listen((state) {
      if (state != BluetoothAdapterState.on) {
        // Bluetooth turned off or is unavailable
        isDeviceConnected.value = false;
        connectedDevice.value = null;
        statusMessage.value = "Bluetooth is Off";
        // Also ensure scanning stops
        if (isScanning.value) {
          stopScan();
        }
      }
    });
  }

  @override
  void onClose() {
    _scanSubscription?.cancel();
    _connectionSubscription?.cancel();
    _stopRssiMonitoring();
    super.onClose();
  }

  /// Starts the process: Request Permissions -> Scan -> Connect
  Future<void> startAutoConnect({bool manual = false}) async {
    bool permissionsGranted = await _requestPermissions();
    if (!permissionsGranted) {
      statusMessage.value = "Permissions denied";
      return;
    }

    // Check if Bluetooth is On
    if (await FlutterBluePlus.adapterState.first != BluetoothAdapterState.on) {
      if (GetPlatform.isAndroid) {
        try {
          await FlutterBluePlus.turnOn();
        } catch (e) {
          Get.snackbar(
            "Bluetooth Required",
            "Please turn on Bluetooth to connect",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Get.theme.colorScheme.error,
            colorText: Get.theme.colorScheme.onError,
          );
          statusMessage.value = "Bluetooth is Off";
          return;
        }
      } else {
        // iOS or others
        Get.snackbar(
          "Bluetooth Required",
          "Please turn on Bluetooth to connect",
          snackPosition: SnackPosition.BOTTOM,
        );
        statusMessage.value = "Bluetooth is Off";
        return;
      }
    }

    _scanForDevice(showDialog: manual);
  }

  Future<bool> _requestPermissions() async {
    // Android 12+ requires specific permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    if (statuses[Permission.bluetoothScan]?.isGranted == true &&
        statuses[Permission.bluetoothConnect]?.isGranted == true) {
      return true;
    }

    // Fallback for older Android versions (Location permission usually sufficient)
    if (statuses[Permission.location]?.isGranted == true) {
      return true;
    }

    return false;
  }

  void _scanForDevice({bool showDialog = false}) {
    if (isDeviceConnected.value) return;

    // Safety Check: Don't scan if BT is off
    if (FlutterBluePlus.adapterStateNow != BluetoothAdapterState.on) {
      statusMessage.value = "Bluetooth is Off";
      isScanning.value = false;
      return;
    }

    if (showDialog && !Get.isDialogOpen!) {
      Get.dialog(const ScanningDialog(), barrierDismissible: false);
    }

    statusMessage.value = "جاري البحث عن حامي الهاتف...";
    isScanning.value = true;

    // Start scanning
    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 10),
      withNames: [targetDeviceName],
    );

    _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.platformName == targetDeviceName ||
            r.device.platformName == targetDeviceName) {
          // Fix 2: Use platformName
          FlutterBluePlus.stopScan();
          statusMessage.value = "تم العثور عليه! جاري الاتصال...";
          _connectToDevice(r.device);
          break;
        }
      }
    });
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
    isScanning.value = false;
    statusMessage.value = "Disconnected";
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    statusMessage.value = "Connecting to ${device.platformName}...";

    try {
      await device.connect(
        license: License.free,
        timeout: const Duration(seconds: 5),
      );
      connectedDevice.value = device;

      // Listen to connection state
      _connectionSubscription = device.connectionState.listen((state) {
        if (state == BluetoothConnectionState.connected) {
          isDeviceConnected.value = true;
          statusMessage.value = "Connected";
          if (Get.isDialogOpen == true) Get.back();
          _discoverServices(device);
          _startRssiMonitoring(device); // Start RSSI Loop
        } else if (state == BluetoothConnectionState.disconnected) {
          isDeviceConnected.value = false;
          connectedDevice.value = null;
          writeCharacteristic = null;
          _stopRssiMonitoring(); // Stop RSSI Loop

          // Only retry valid disconnects if Bluetooth is ON
          if (FlutterBluePlus.adapterStateNow == BluetoothAdapterState.on) {
            statusMessage.value = "Disconnected - Retrying...";
            _scanForDevice();
          } else {
            statusMessage.value = "Bluetooth is Off";
          }
        }
      });
    } catch (e) {
      statusMessage.value = "Connection Failed";
      // Fix 3: Remove print or use debugPrint/log if needed. Removing for clean production code.
      Get.log("Connection Error: $e");
      _scanForDevice();
    }
  }

  Future<void> _discoverServices(BluetoothDevice device) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.properties.write ||
              characteristic.properties.writeWithoutResponse) {
            writeCharacteristic = characteristic;
            Get.log("Write Characteristic Found: ${characteristic.uuid}");
          }
        }
      }
    } catch (e) {
      Get.log("Service Discovery Error: $e");
    }
  }

  // --- RSSI Monitoring (Smart Logic like ESP32) ---

  void _startRssiMonitoring(BluetoothDevice device) {
    _rssiBuffer.clear();
    _farCount = 0;
    _rssiTimer?.cancel();

    _rssiTimer = Timer.periodic(const Duration(milliseconds: 500), (
      timer,
    ) async {
      if (isDeviceConnected.value &&
          FlutterBluePlus.adapterStateNow == BluetoothAdapterState.on) {
        try {
          int rawRssi = await device.readRssi();

          // 1. Spike Rejection (Noise Filter)
          if (_rssiBuffer.isNotEmpty) {
            int currentAvg =
                _rssiBuffer.reduce((a, b) => a + b) ~/ _rssiBuffer.length;
            if (rawRssi < -95 && currentAvg > -80) {
              Get.log("BleController: Ignored Spike $rawRssi");
              return;
            }
          }

          // 2. SMA Filter (Smooth)
          _rssiBuffer.add(rawRssi);
          if (_rssiBuffer.length > _smaSize) _rssiBuffer.removeAt(0);
          int smoothedRssi =
              _rssiBuffer.reduce((a, b) => a + b) ~/ _rssiBuffer.length;

          // 3. Convert to Meters
          // Formula: d = 10 ^ ((Measured Power - RSSI) / (10 * N))
          // Measured Power @ 1m: -59, N: 2.5
          double dist = math
              .pow(
                // Updated prefix
                10,
                ((-59 - smoothedRssi) / (10 * 2.5)),
              )
              .toDouble();
          estimatedDistance.value = double.parse(dist.toStringAsFixed(1));

          // 4. Smart Safety Status (Debounce)
          // Add Safety Margin (+5) to make App slightly more sensitive than ESP32
          // This ensures the App turns RED *before* or *at the same time* the motor vibrates.
          int effectiveThreshold = currentThreshold.value + 5;

          if (smoothedRssi < effectiveThreshold) {
            _farCount++;
          } else {
            _farCount = 0;
            isSafe.value = true;
          }

          if (_farCount >= _farThreshold) {
            isSafe.value = false;
          }
        } catch (e) {
          Get.log("RSSI Read Error: $e");
        }
      } else {
        timer.cancel();
      }
    });
  }

  void _stopRssiMonitoring() {
    _rssiTimer?.cancel();
  }

  // --- Commands ---

  Future<void> sendCommand(String command) async {
    if (writeCharacteristic == null) {
      Get.log("Not connected or Write Characteristic not found");
      return;
    }

    try {
      await writeCharacteristic!.write(command.codeUnits);
    } catch (e) {
      Get.log("Write Error: $e");
    }
  }

  void setDistance(int distance) {
    // Calculate expected threshold based on distance (Logic from ESP32 Code)
    // 1 -> -65, 2 -> -75, etc. approximate mapping if needed,
    // OR just rely on the same calculation for consistency.
    // ESP32 Logic: rssiThreshold = -55 - (val * 10) for val <= 10

    int newThreshold = -75; // Default fallback
    if (distance > 0 && distance <= 10) {
      newThreshold = -55 - (distance * 10);
    } else {
      // Should not happen with slider but safe fallback
      newThreshold = -1 * distance;
    }

    currentThreshold.value = newThreshold;
    Get.log("App Threshold Updated: $newThreshold for Distance: $distance");

    sendCommand("SET_DISTANCE:$distance");
  }

  void setVibrationDuration(int seconds) {
    sendCommand("SET_VIB_TIME:$seconds");
  }

  void setVibrationPattern(bool isContinuous) {
    String mode = isContinuous ? "CONTINUOUS" : "INTERMITTENT";
    sendCommand("SET_MODE:$mode");
  }

  void setServiceState(bool isActive) {
    String mode = isActive ? "SERVICE_ON" : "SERVICE_OFF";
    sendCommand(mode);
  }
}
