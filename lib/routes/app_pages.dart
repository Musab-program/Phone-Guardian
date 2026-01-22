import 'package:get/get.dart';

import '../pages/home/home_binding/home_binding.dart';
import '../pages/home/views/home_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(name: Routes.HOME, page: () => HomePage(),
        binding: HomeBinding()),

    // GetPage(
    //   name: Routes.NOTE,
    //   page: () => NotePage(),
    //   binding: NoteBindings(),
    // ),
  ];
}
