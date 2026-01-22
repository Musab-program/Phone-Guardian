import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sidebarx/sidebarx.dart';

import '../base_controllers/app_controller.dart';
import '../constants/app_color.dart';

final controller =
    Get.find<
      AppController
    >(); // Keep this globally if it's used elsewhere, but safest to move inside. Wait, user might rely on it. Actually, I should remove it to be safe, but if I remove it, I must update all references.
// The instruction above said "Remove global controller".
// But `replace_file_content` replaces a range.

// Let's replace the whole file content effectively or the class.
// Wait, replacing the whole class + global var is best.

class CustomDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomDrawer({
    Key? key,
    required SidebarXController controller,
    required this.scaffoldKey,
  }) : _controller = controller,
       super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    AppController appController = Get.find();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark ? Colors.white : Colors.black87;
    final iconColor = isDark ? Colors.white70 : Colors.black54;
    final selectedColor = isDark
        ? AppColors.accentColor
        : AppColors.primaryColor;

    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurface
              : AppColors.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: isDark ? Colors.white10 : Colors.black12,
        textStyle: TextStyle(color: iconColor),
        selectedTextStyle: TextStyle(color: selectedColor),
        hoverTextStyle: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.transparent),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selectedColor.withOpacity(0.37)),
          gradient: LinearGradient(
            colors: isDark
                ? [
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.05),
                  ]
                : [
                    AppColors.primaryColor.withOpacity(0.1),
                    AppColors.primaryColor.withOpacity(0.1),
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: iconColor, size: 20),
        selectedIconTheme: IconThemeData(color: selectedColor, size: 20),
      ),
      extendedTheme: SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurface
              : AppColors.scaffoldBackgroundColor,
        ),
      ),
      footerDivider: Divider(color: iconColor.withOpacity(0.3), height: 1),
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 190, // Increased height to fix overflow
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20), // Lower content as requested
                Image.asset(
                  "lib/assets/img/app_lanchuer.png",
                  height: extended ? 100 : 45,
                  width: extended ? 100 : 45,
                  fit: BoxFit.contain,
                ),
                if (extended) ...[
                  const SizedBox(height: 12),
                  Text(
                    "appName".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home_rounded,
          label: 'Home',
          onTap: () {
            debugPrint('Home');
          },
        ),
        SidebarXItem(
          icon: Icons.brightness_6_rounded,
          label: "theme".tr,
          onTap: () {
            Get.defaultDialog(
              title: "chooseTheme".tr,
              backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
              titleStyle: TextStyle(color: textColor),
              content: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                child: Column(
                  children: [
                    Divider(color: iconColor.withOpacity(0.2)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "light".tr,
                                  style: TextStyle(color: textColor),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.light_mode_rounded,
                                  color: Colors.orange,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            appController.toggleTheme(false);
                            Get.back();
                            scaffoldKey.currentState!.closeDrawer();
                          },
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "dark".tr,
                                  style: TextStyle(color: textColor),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.dark_mode_rounded,
                                  color: Colors.indigo,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            appController.toggleTheme(true);
                            Get.back();
                            scaffoldKey.currentState!.closeDrawer();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SidebarXItem(
          icon: Icons.language_rounded,
          label: "language".tr,
          onTap: () {
            Get.defaultDialog(
              title: "chooseLan".tr,
              backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
              titleStyle: TextStyle(color: textColor),
              content: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      child: Card(
                        color: isDark ? Colors.black26 : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: iconColor.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.primaryColor.withOpacity(
                              0.1,
                            ),
                            child: Text(
                              "ض",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          title: Text(
                            "arabic".tr,
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ),
                      onTap: () {
                        appController.changeLan("ar");
                        Get.back();
                        scaffoldKey.currentState!.closeDrawer();
                      },
                    ),
                    SizedBox(height: 8),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      child: Card(
                        color: isDark ? Colors.black26 : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: iconColor.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.primaryColor.withOpacity(
                              0.1,
                            ),
                            child: Text(
                              "A",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          title: Text(
                            "english".tr,
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ),
                      onTap: () {
                        appController.changeLan("en");
                        Get.back();
                        scaffoldKey.currentState!.closeDrawer();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SidebarXItem(
          icon: Icons.info_rounded,
          label: "about"
              .tr, // Ensure 'about' key exists or use hardcoded if lazy (will add key)
          onTap: () {
            Get.defaultDialog(
              title: "about".tr,
              backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
              titleStyle: TextStyle(color: textColor),
              content: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset("lib/assets/img/app_lanchuer.png", height: 80),
                    const SizedBox(height: 16),
                    Text(
                      "appName".tr,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("Version 1.0.0", style: TextStyle(color: iconColor)),
                    const SizedBox(height: 16),
                    Text(
                      "aboutDescription".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textColor),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

const primaryColor = Color(0xFF6FFBFF);
const scaffoldBackgroundColor = Color(0xFF674667);
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: AppColors.textIcons, height: 1);
