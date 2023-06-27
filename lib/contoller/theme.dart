// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ThemeController extends GetxController {
//   Rx<ThemeMode> themeMode = ThemeMode.system.obs;
//
//   void changeThemeMode(ThemeMode mode) {
//     themeMode.value = mode;
//     Get.changeThemeMode(mode);
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final Rx<Color> appBarColor = Colors.red.obs;
  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  void updateAppBarColor(Color color) {
    appBarColor.value = color;
  }
}



class ThemeControllersystem extends GetxController {
  RxBool isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
