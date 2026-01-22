import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_guardian/core/utils/themes.dart';

import '../services/preference_Service.dart';

class AppController extends GetxController {
  final PreferenceService _prefsService = Get.find<PreferenceService>();
  RxBool isDarkMode = false.obs;
  static const String _themeKey = 'isDarkMode';
  static const String _lanKey = 'language';

  RxInt selectedIndex = 0.obs;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
    _loadThemeMode();
    _loadLanguage();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  void _loadThemeMode() async {
    isDarkMode.value = _prefsService.getBool(_themeKey) ?? false;
    Get.changeTheme(isDarkMode.value ? AppThemes.dark : AppThemes.light);
  }

  void toggleTheme(bool value) async {
    isDarkMode.value = value;
    Get.changeTheme(isDarkMode.value ? AppThemes.dark : AppThemes.light);
    await _prefsService.setBool(_themeKey, isDarkMode.value);
  }

  void _loadLanguage() async {
    final savedLangCode = _prefsService.getString(_lanKey);
    savedLangCode == null ? Get.deviceLocale : changeLan(savedLangCode);
  }

  void changeLan(String codeLan) async {
    Locale locale = Locale(codeLan);
    Get.updateLocale(locale);
    await _prefsService.setString(_lanKey, codeLan);
  }

  // void refreshAllData() {
  //   if (Get.isRegistered<HomeController>()) {
  //     Get.find<HomeController>().loadData();
  //   }
  //   if (Get.isRegistered<UserManagementController>()) {
  //     Get.find<UserManagementController>().fetchUsers();
  //   }
  //   if (Get.isRegistered<DashboardController>()) {
  //     Get.find<DashboardController>().fetchDashboardData();
  //
  //
  //   }
}
