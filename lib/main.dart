import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quotes_app/views/screens/HomePage.dart';
import 'package:quotes_app/views/screens/edit_page.dart';
import 'package:quotes_app/views/screens/second_page.dart';
import 'package:quotes_app/views/screens/themescreen.dart';
import 'package:quotes_app/views/spalsh_screen/splashscreen.dart';
import 'contoller/theme.dart';


void main()async{
  await GetStorage.init();
  ThemeController _themeController = Get.put(ThemeController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: '/HomePage',
      getPages: [
        GetPage(name: "/HomePage",page:() => const HomePage(),),
        GetPage(name: "/second",page:() => const second_page(),),
        GetPage(name: "/edit",page:() => const Edit_page(),),
        GetPage(name: "/theme",page:() =>   ThemeScreen(),),
        GetPage(name: "/",page:() =>  const Onboarding(),),
      ],
    ),
  );
}