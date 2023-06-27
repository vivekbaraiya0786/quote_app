import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contoller/controller.dart';
import '../../utils/attributes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final QuotesController _quotesController = Get.put(QuotesController());

  bool isDarkMode = Get.isDarkMode;


  final List<Color> _colors = List.generate(
    18,
        (index) => Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
  );
  late List<Color> _containerColors;
  final Random _random = Random();
  @override
  void initState() {
    super.initState();
    _containerColors = List.generate(_colors.length, (index) => _colors[index]);
  }

  void _changeContainerColor(int index) {
    setState(() {
      _containerColors[index] = _getRandomColor();
    });
  }

  Color _getRandomColor() {
    return _colors[_random.nextInt(_colors.length)];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: Get.height * 0.25,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage(
                      "assets/other images/pexels-photo-2406449.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 30, left: 15),
                child: Text(
                  "English Quotes",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.list_alt,
              ),
              title: Text("Quote Category"),
            ),
            const ListTile(
              leading: Icon(
                Icons.water,
              ),
              title: Text("Other Quote"),
            ),
            const ListTile(
              leading: Icon(
                CupertinoIcons.heart_fill,
              ),
              title: Text("My Favorite"),
            ),
            const ListTile(
              leading:  Icon(
                Icons.refresh_sharp,
              ),
              title:  Text("Theme"),
              // trailing: IconButton(
              //     onPressed: () {
              //       if (Get.isDarkMode) {
              //         themeController.changeThemeMode(ThemeMode.light);
              //       } else {
              //         themeController.changeThemeMode(ThemeMode.dark);
              //       }
              //     },
              //     icon: (Get.isDarkMode)
              //         ? const Icon(Icons.light_mode)
              //         : const Icon(Icons.dark_mode_outlined)),
            ),
            const ListTile(
              leading: Icon(
                Icons.edit_attributes_outlined,
              ),
              title: Text("Rate & Review"),
            ),
            const ListTile(
              leading: Icon(
                Icons.feedback,
              ),
              title: Text("Feedback"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.list_rounded),
          onPressed: () {
            if (scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.closeDrawer();
            } else {
              scaffoldKey.currentState!.openDrawer();
            }
          },
        ),
        title: const Text(
          "Quotes",
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: _quotesController.loadJSON,
        //     icon: const Icon(Icons.change_circle),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(
          () => Container(
            alignment: Alignment.center,
            child: (_quotesController.quotes.isEmpty)
                ? const Text("No data available")
                : GridView.builder(
                    itemCount: _quotesController.quotes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final quote = _quotesController.quotes[index];
                      final containerColor = _containerColors[index % _containerColors.length];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed("/second", arguments: quote);
                        },
                        child: Card(
                          elevation: 10,
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.017,
                              ),
                              Container(
                                height: Get.height * 0.14,
                                width: Get.width * 0.3,
                                decoration: BoxDecoration(
                                  color: containerColor.withOpacity(0.7),
                                  // color: _colors[index % _colors.length]
                                  //     .withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(quote.image, scale: 6),
                              ),
                              SizedBox(
                                height: Get.height * 0.012,
                              ),
                              Text(
                                quote.category,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
// final List<Color> _colors = [
//   const Color(0xffa61102),
//   const Color(0xff02472B),
//   const Color(0xffFE7DA6),
//   const Color(0xff3c4e4e),
//   const Color(0xff2a603c),
//   const Color(0xffdd7289),
//   const Color(0xffdf5219),
//   const Color(0xff37556A),
//   const Color(0xff1eb290),
//   const Color(0xff9b2339),
//   const Color(0xff2a2b22),
//   const Color(0xffbb002f),
//   const Color(0xff49be6f),
//   const Color(0xffea0132),
//   const Color(0xffc41859),
//   const Color(0xff830000),
//   const Color(0xff780100),
//   const Color(0xfffb4b43),
//   const Color(0xff780100),
//   const Color(0xffe2425f),
//   const Color(0xff770101),
//   const Color(0xff355265),
//   const Color(0xff000085),
//   const Color(0xff2b5b36),
//   const Color(0xfffd4c3c),
//   const Color(0xff1cb394),
//   const Color(0xff292b1d),
//   const Color(0xff9f203a),
//   const Color(0xffc81759),
//   const Color(0xffe60059),
//   const Color(0xff09422a),
//   const Color(0xffe63f58),
//   const Color(0xffa91100),
// ];
