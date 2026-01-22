import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final SidebarXController controller;

  const HomeAppbar({
    super.key,
    required this.scaffoldKey,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).primaryColor,
      elevation: 0,
      title: Text(
        "appName".tr,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          if (!Platform.isAndroid && !Platform.isIOS) {
            controller.setExtended(true);
          }
          scaffoldKey.currentState?.openDrawer();
        },
        icon: const Icon(Icons.settings, color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
