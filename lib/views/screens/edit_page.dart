import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../contoller/theme.dart';
import '../../modals/qoute_databse.dart';
import '../../utils/attributes.dart';

class Edit_page extends StatefulWidget {
  const Edit_page({Key? key}) : super(key: key);

  @override
  State<Edit_page> createState() => _Edit_pageState();
}

class _Edit_pageState extends State<Edit_page> {


  void savegallery() async {
    Uint8List? capturedImage = await screenshotController.capture();

    if (capturedImage != null) {
      await ImageGallerySaver.saveImage(capturedImage);
      Get.snackbar(
        'Success',
        'Image saved successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to save image',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  Future<void> setWallpaper() async {
    Uint8List? imageBytes = await screenshotController.capture();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String imagePath = '$tempPath/wallpaper.png';
    File file = File(imagePath);
    await file.writeAsBytes(imageBytes!);

    WallpaperManager.setWallpaperFromFile(
        imagePath, WallpaperManager.HOME_SCREEN);
    WallpaperManager.setWallpaperFromFile(
        imagePath, WallpaperManager.LOCK_SCREEN);
    WallpaperManager.setWallpaperFromFile(
        imagePath, WallpaperManager.BOTH_SCREEN);
    Get.snackbar("Wallpaper", "Successfully Wallpaper apply",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey.withOpacity(0.5),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(seconds: 1));
  }

  final ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final quote = Get.arguments as String;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            title: Text(
              'Edit image',
              style: GoogleFonts.lilitaOne(),
            ),
            centerTitle: true,
            backgroundColor: _themeController.appBarColor.value,
          ),
        ),
      ),
      body: FutureBuilder<List<QuotesDatabaseModel>?>(
        future: getAllQuotes!,
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
              final quoteModel = data.firstWhere(
                (quoteModel) => quoteModel.quotes == quote,
                orElse: () =>
                    QuotesDatabaseModel(id: null, quotes: '', author: ''),
              );
              return Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentImageIndex =
                                (currentImageIndex + 1) % imageList.length;
                            showImages = true;
                            selectedBackgroundColor = Colors.grey;
                          });
                        },
                        child: Screenshot(
                          controller: screenshotController,
                          child: Container(
                            height: Get.height * 0.5,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: showImages
                                  ? Colors.transparent
                                  : selectedBackgroundColor,
                              image: showImages
                                  ? DecorationImage(
                                      image: AssetImage(
                                          imageList[currentImageIndex]),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  quote,
                                  style: TextStyle(
                                    color: selectedFontColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: textSize,
                                    letterSpacing: textLineSpace,
                                    height: textLineSpace + verticalSpacing,
                                    fontFamily: googleFonts[currentFontIndex],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Font Size",
                              style: GoogleFonts.hind(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (textSize >= 11) {
                                        textSize = textSize - 1.0;
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: Get.height * 0.05,
                                    width: Get.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(Icons.remove),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Text(
                                  "$textSize",
                                  style: GoogleFonts.hind(
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (textSize <= 29) {
                                        textSize = textSize + 1.0;
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: Get.height * 0.05,
                                    width: Get.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Font Line Space",
                              style:
                                  GoogleFonts.hind(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (verticalSpacing > 0.1) {
                                        verticalSpacing -= 0.1;
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: Get.height * 0.05,
                                    width: Get.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(Icons.remove),
                                  ),
                                ),
                                SizedBox(width: Get.width * 0.05),
                                Text(
                                  verticalSpacing.toStringAsFixed(1),
                                  style: GoogleFonts.hind(
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      verticalSpacing += 0.1;
                                    });
                                  },
                                  child: Container(
                                    height: Get.height * 0.05,
                                    width: Get.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Background Color",
                              style:
                                  GoogleFonts.hind(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      Container(
                                        height: Get.height * 0.4,
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                            ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Select Color",
                                                      style: GoogleFonts.hind(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4,
                                                  mainAxisSpacing: 8.0,
                                                  crossAxisSpacing: 8.0,
                                                ),
                                                itemCount:
                                                    containerColor.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedBackgroundColor =
                                                            containerColor[
                                                                index];
                                                        showImages = false;
                                                      });
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: containerColor[
                                                            index],
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: Get.height * 0.05,
                                    width: Get.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(Icons.color_lens),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Font Color",
                              style:
                                  GoogleFonts.hind(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      Container(
                                        height: Get.height * 0.4,
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Select Color",
                                                      style: GoogleFonts.hind(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4,
                                                  mainAxisSpacing: 8.0,
                                                  crossAxisSpacing: 8.0,
                                                ),
                                                itemCount: Fontcolors.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedFontColor =
                                                            Fontcolors[index];
                                                      });
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Fontcolors[index],
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: Get.height * 0.05,
                                    width: Get.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(Icons.color_lens),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Font Style",
                              style:
                                  GoogleFonts.hind(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentFontIndex =
                                          (currentFontIndex + 1) %
                                              googleFonts.length;
                                    });
                                  },
                                  child: Container(
                                    height: Get.height * 0.05,
                                    width: Get.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child:
                                        const Icon(Icons.text_format_outlined),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Set As wallpaper",
                              style:
                                  GoogleFonts.hind(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setWallpaper();
                                  },
                                  child: Container(
                                    height: Get.height * 0.05,
                                    width: Get.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(Icons.wallpaper_outlined),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: savegallery,
                            child: Container(
                              height: Get.height * 0.06,
                              width: Get.width * 0.3,
                              decoration: (BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.save),
                                  Text(
                                    "Save",
                                    style: GoogleFonts.hind(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: quote))
                                  .then(
                                (value) => Get.snackbar(
                                  "Quote",
                                  "Successfully Copy",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                  duration: const Duration(
                                    seconds: 3,
                                  ),
                                  animationDuration: const Duration(
                                    seconds: 1,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: Get.height * 0.06,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.copy),
                                  Text(
                                    "Copy",
                                    style: GoogleFonts.hind(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Share.share(quote);
                            },
                            child: Container(
                              height: Get.height * 0.06,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(
                                    Icons.share,
                                  ),
                                  Text(
                                    "Share",
                                    style: GoogleFonts.hind(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
