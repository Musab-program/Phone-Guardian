import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sidebarx/sidebarx.dart';

import '../../../core/widgets/custom_drawer.dart';
import '../widget/home_header.dart';
import '../widget/protection_settings_card.dart';
import '../widget/home_appbar.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final SidebarXController _controller = SidebarXController(
    selectedIndex: 0,
    extended: true,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Ensure controller is registered if not already
    // final HomeController homeController = Get.find(); // Not strictly needed if children use Get.find

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: CustomDrawer(controller: _controller, scaffoldKey: _scaffoldKey),
      appBar: HomeAppbar(scaffoldKey: _scaffoldKey, controller: _controller),

      body: Stack(
        children: [
          // Background/Header Area
          Column(children: [const HomeHeader()]),

          // Main Content
          Padding(
            padding: const EdgeInsets.only(top: 170.0), // Lifted higher
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ProtectionSettingsCard(),
                  const SizedBox(height: 20),
                  // Additional widgets if needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
