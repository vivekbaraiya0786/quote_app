import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../contoller/theme.dart';


class ThemeScreen extends StatefulWidget {
  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
              () => AppBar(
            title:  Text("Theme",style: GoogleFonts.lilitaOne()),
            backgroundColor: _themeController.appBarColor.value,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Get.changeThemeMode(ThemeMode.dark);
                },
                leading: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.06,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
                title:  Text("Default Theme / Dark Theme",style: GoogleFonts.hind()),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Get.changeThemeMode(ThemeMode.system);
                },
                leading: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.06,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                title:  Text("System Theme",style: GoogleFonts.hind()),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Get.changeThemeMode(ThemeMode.light);
                },
                leading: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
                title:  Text("Light Theme",style: GoogleFonts.hind()),
              ),
              const Divider(),

              Obx(
                    () => buildColorTile(
                  Colors.red,
                  "Red Theme",
                  _themeController.appBarColor.value,
                ),
              ),
              const Divider(),
              Obx(
                    () => buildColorTile(
                  Colors.blue,
                  "Blue Theme",
                  _themeController.appBarColor.value,
                ),
              ),
              const Divider(),
              Obx(
                    () => buildColorTile(
                  Colors.pink,
                  "Pink Theme",
                  _themeController.appBarColor.value,
                ),
              ),
              const Divider(),
              Obx(
                    () => buildColorTile(
                  Colors.green,
                  "Green Theme",
                  _themeController.appBarColor.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildColorTile(Color color, String title, Color currentColor) {
    return ListTile(
      onTap: () {
        _themeController.updateAppBarColor(color);
      },
      leading: Container(
        height: Get.height * 0.03,
        width: Get.width * 0.06,
        decoration: BoxDecoration(
          color: color,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.hind(
          fontWeight: currentColor == color ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
