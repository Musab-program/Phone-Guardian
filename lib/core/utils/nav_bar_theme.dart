import 'dart:ui';

import '../constants/app_color.dart';

class CustomGNavTheme {
  static const light = {
    'tabBackgroundColor': AppColors.darkPrimaryColor,
    'rippleColor': Color.fromRGBO(210, 210, 210, 1),
    'hoverColor': Color.fromRGBO(240, 240, 240, 1),
    'activeColor': AppColors.textIcons,
    'iconColor': AppColors.primaryText,
    'textColor': AppColors.textIcons,
  };
  static const dark = {
    'tabBackgroundColor': AppColors.darkPrimaryColor,
    'rippleColor': Color.fromRGBO(70, 70, 70, 1),
    'hoverColor': Color.fromRGBO(50, 50, 50, 1),
    'activeColor': AppColors.textIcons,
    'iconColor': AppColors.textIcons,
    'textColor': AppColors.primaryText,
  };
}
