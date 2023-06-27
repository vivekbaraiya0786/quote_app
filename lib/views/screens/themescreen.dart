import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
      ),
      body: Padding(
        padding: EdgeInsets.all(14),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                },
                leading: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                ),
                title: Text("Default Theme / Dark Theme"),
              ),
              Divider(),
              ListTile(
                onTap: () {
                },
                leading: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.grey
                  ),
                ),
                title: Text("System Theme"),
              ),
              Divider(),
              ListTile(
                onTap: () {
                },
                leading: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                      color: Colors.grey
                  ),
                ),
                title: Text("Light Theme"),
              ),
              Divider(),
              ListTile(
                onTap: () {
                },
                leading: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                      color: Colors.red
                  ),
                ),
                title: Text("Red Theme"),
              ),
              Divider(),
              ListTile(
                onTap: () {
                },
                leading: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                  ),
                ),
                title: Text("Blue Theme"),
              ),
              Divider(),
              ListTile(
                onTap: () {
                },
                leading: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                      color: Colors.pink
                  ),
                ),
                title: Text("Pink Theme"),
              ),
              Divider(),
              ListTile(
                onTap: () {
                },
                leading: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                      color: Colors.green
                  ),
                ),
                title: Text("Green Theme"),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
