import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:phone_guardian/core/base_controllers/app_controller.dart';
import 'package:phone_guardian/core/utils/themes.dart';
import 'package:phone_guardian/routes/app_pages.dart';
import 'core/bindings/app_binding.dart';
import 'core/constants/translation.dart';
import 'core/services/preference_Service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferenceService = await PreferenceService.initAndCreate();
  Get.put<PreferenceService>(preferenceService, permanent: true);
  AppBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppController appController = Get.find();
    return Obx(() {
      return GetMaterialApp(
        title: 'title'.tr,
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: appController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,

        fallbackLocale: const Locale('en', 'US'),
        translations: AppTranslation(),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    });
  }
}
