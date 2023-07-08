import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import '../../contoller/category_controller.dart';
import '../../contoller/favourite.dart';
import '../../contoller/qoutes_controller.dart';
import '../../contoller/theme.dart';
import '../../modals/qoute_databse.dart';
import '../../utils/attributes.dart';
import '../../utils/helpers/DBhelper.dart';
import 'edit_page.dart';

class second_page extends StatefulWidget {
  const second_page({super.key});

  @override
  State<second_page> createState() => _second_pageState();
}

class _second_pageState extends State<second_page> {


  void changeGradientColor(int index) {
    setState(() {
      if (containerColors.length <= index) {
        containerColors.add(getRandomColor());
      } else {
        containerColors[index] = getRandomColor();
      }
    });
  }

  Color getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
        .withOpacity(1.0);
  }
  final FavoriteController favoriteController = Get.put(FavoriteController());

  CategoryController categoryController = Get.find<CategoryController>();
  final ThemeController _themeController = Get.find<ThemeController>();
  GetQuotesController getQuotesController = Get.put(GetQuotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
              () => AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: Obx(
                  () => Text(
                categoryController.categoryName.value,
                style: GoogleFonts.lilitaOne(),
              ),
            ),
            centerTitle: true,
            backgroundColor: _themeController.appBarColor.value,
          ),
        ),
      ),
      body: GetBuilder<GetQuotesController>(
        builder: (context) {
          return FutureBuilder(
            future: getAllQuotes,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("ERROR : ${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                List<QuotesDatabaseModel>? data = snapshot.data;


                if (data == null || data.isEmpty) {
                  return const Center(
                    child: Text("NO DATA AVAILABLE"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final quote = data[index].quotes;
                      final isFavorite = favoriteController.isFavorite(quote);
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: GestureDetector(
                          onTap: () => changeGradientColor(index),
                          child: Container(
                            height: Get.height * 0.35,
                            width: Get.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  containerColors.length > index
                                      ? containerColors[index]
                                      : Colors.red,
                                  Colors.blue,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(14),
                                        child: Text(
                                          data[index].quotes,
                                          style: GoogleFonts.teko(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            data[index].author,
                                            style: GoogleFonts.bebasNeue(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (data[index].favorite == 0) {
                                                DBHelper.dbHelper.updateQuote(favorite: 1, quote: data[index].quotes);
                                                QuotesDatabaseModel quotesDataBaseModel = QuotesDatabaseModel(
                                                  id: data[index].id,
                                                  quotes: data[index].quotes,
                                                  author: data[index].author,
                                                  favorite: data[index].favorite,
                                                );
                                                DBHelper.dbHelper.insertFavorite(data: quotesDataBaseModel);
                                              } else {
                                                DBHelper.dbHelper.updateSecondQuote(favorite: 0, quote: data[index].quotes);
                                                DBHelper.dbHelper.deleteFavorite(quote: data[index].quotes);
                                              }
                                              getQuotesController.getQuotesList(
                                                allQuotes: DBHelper.dbHelper.fatchAllQuotes(id: data[index].id!),
                                              );
                                              print(data[index].id);
                                              favoriteController.toggleFavorite(quote);
                                            },
                                            child: Container(
                                              height: Get.height * 0.05,
                                              width: Get.width * 0.13,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.heart,
                                                color: isFavorite ? Colors.red : Colors.black,
                                              ),
                                            ),
                                          ),

                                          GestureDetector(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                text: data[index].quotes,
                                              )).then(
                                                    (value) => Get.snackbar(
                                                    "Quote", "Successfully Copy",
                                                    snackPosition:
                                                    SnackPosition.BOTTOM,
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.5),
                                                    duration:
                                                    const Duration(seconds: 3),
                                                    animationDuration:
                                                    const Duration(seconds: 1)),
                                              );
                                            },
                                            child: Container(
                                              height: Get.height * 0.05,
                                              width: Get.width * 0.13,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: const Icon(Icons.copy,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                SwipeablePageRoute(
                                                  canSwipe: true,
                                                  transitionDuration:
                                                  const Duration(
                                                      milliseconds: 1000),
                                                  builder: (BuildContext context) =>
                                                  const Edit_page(),
                                                  settings: RouteSettings(
                                                    arguments: data[index].quotes,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: Get.height * 0.05,
                                              width: Get.width * 0.13,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: const Icon(Icons.edit,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Share.share(data[index].quotes);
                                            },
                                            child: Container(
                                              height: Get.height * 0.05,
                                              width: Get.width * 0.13,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: const Icon(Icons.share,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
              return  CircularProgressIndicator();
            },
          );
        }
      ),
    );
  }
}
