import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/views/screens/HomePage.dart';
import 'package:quotes_app/views/screens/edit_page.dart';
import 'package:quotes_app/views/screens/second_page.dart';
import 'package:quotes_app/views/screens/themescreen.dart';
import 'package:quotes_app/views/spalsh_screen/1.dart';


void main(){
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: "/",page:() => const HomePage(),),
        GetPage(name: "/second",page:() => const second_page(),),
        GetPage(name: "/edit",page:() => const Edit_page(),),
        GetPage(name: "/theme",page:() =>  const ThemeScreen(),),
        GetPage(name: "/spalshscreen1",page:() =>  const spalshscreen1(),),
      ],
    ),
  );
}