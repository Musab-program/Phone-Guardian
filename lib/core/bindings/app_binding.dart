import 'package:get/get.dart';

import '../../pages/home/controllers/home_controller.dart';
import '../base_controllers/app_controller.dart';
import '../controllers/ble_controller.dart';
import '../services/preference_Service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<PreferenceService>(Get.find<PreferenceService>(), permanent: true);
    Get.put<AppController>(AppController());
    Get.put<BleController>(
      BleController(),
      permanent: true,
    ); // BleController persists

    Get.lazyPut(() => HomeController());
  }
}
