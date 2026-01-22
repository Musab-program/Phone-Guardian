import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 15,
        left: 20,
        right: 20,
        bottom: 90,
      ), // Reduced bottom padding
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Obx(() {
              final isConnected = controller.isConnected.value;
              // Define State
              bool isServiceActive = controller.isServiceActive.value;
              bool isSafe = controller.bleController.isSafe.value;

              // Pulse Logic:
              // 1. Disconnected -> Pulse White (Searching)
              // 2. Connected + Service Active + Safe -> Pulse Green
              // 3. Connected + Service Active + Unsafe -> Pulse Red
              // 4. Connected + Service Inactive -> Stop Animation (Static)

              Color pulseColor = Colors.white;

              if (!isConnected) {
                _animationController.repeat(reverse: true);
                pulseColor = Colors.white.withOpacity(0.3);
              } else {
                if (isServiceActive) {
                  _animationController.repeat(reverse: true);
                  pulseColor = isSafe
                      ? Colors.green.withOpacity(0.5)
                      : Colors.red.withOpacity(0.5);
                } else {
                  _animationController.stop();
                }
              }

              return GestureDetector(
                // Added Tap to Retry
                onTap: !isConnected ? controller.toggleConnection : null,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Pulse Effect
                    if (!isConnected ||
                        isServiceActive) // Show pulse if disconnected OR service active
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: pulseColor,
                            ),
                          ),
                        ),
                      ),
                    // Main Icon Container
                    Container(
                      padding: const EdgeInsets.all(18), // Reduced padding
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isConnected
                                ? (isServiceActive
                                      ? (isSafe
                                            ? Colors.green.withOpacity(0.5)
                                            : Colors.red.withOpacity(0.5))
                                      : Theme.of(
                                          context,
                                        ).primaryColor.withOpacity(0.5))
                                : Colors.black12,
                            blurRadius: 15, // Reduced blur
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Icon(
                        isConnected
                            ? Icons.bluetooth_connected_rounded
                            : Icons.bluetooth_disabled_rounded,
                        color: Colors.white,
                        size: 45, // Reduced size
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 10), // Reduced from 15
          Obx(() {
            String statusText;
            Color statusColor = Colors.white;

            if (!controller.isConnected.value) {
              statusText = "disconnected".tr;
            } else {
              if (controller.isServiceActive.value) {
                // Show Safe/Unsafe when Service is ON
                statusText = controller.bleController.isSafe.value
                    ? "safe".tr
                    : "notSafe".tr;
                statusColor = controller.bleController.isSafe.value
                    ? Colors.greenAccent
                    : Colors.redAccent;
              } else {
                statusText = "connected".tr;
              }
            }

            return Column(
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 18, // Reduced font size
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                if (!controller.isConnected.value)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "tapToConnect".tr,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  )
                else
                  // Distance Display
                  Text(
                    "~${controller.bleController.estimatedDistance.value} ${"m".tr}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                // Reconnect button removed as per request.
                // Tap on the icon above is used to reconnect.
              ],
            );
          }),
        ],
      ),
    );
  }
}
