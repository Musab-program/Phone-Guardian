import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/widgets/custom_drawer.dart';
import '../controllers/home_controller.dart';

class CustomPopupmenu extends StatelessWidget {
  const CustomPopupmenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Text("edit".tr),
          onTap: (){
            Get.back();
          },
        ),
        PopupMenuItem(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Text("view".tr),
          onTap: (){
            Future.delayed(Duration.zero, () => _showViewOptions(context));          },
        ),
        PopupMenuItem(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Text("addFolder".tr),
          onTap: () {
            // Get.dialog(FolderDialoge());
          },
        ),
      ],

      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}


Future<void> _showViewOptions(BuildContext context) async {
  final homeController = Get.find<HomeController>();

  final RenderBox button = context.findRenderObject() as RenderBox;
  final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(Offset.zero, ancestor: overlay),
      button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );

  await showMenu(
    context: context,
    position: position,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    items: [
      _buildPopupItem("smallGrid".tr, 4, homeController),
      _buildPopupItem("midGrid".tr, 3, homeController),
      _buildPopupItem("largeGrid".tr, 2, homeController),
      _buildPopupItem("list".tr, 1, homeController),
      _buildPopupItem("simpleList".tr, 0, homeController),
    ],
  );
}

PopupMenuItem _buildPopupItem(String text, int value, HomeController controller) {
  return PopupMenuItem(
    child: Text(text),
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),

  );
}
