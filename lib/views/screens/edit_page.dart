import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../modals/qoutes_model.dart';
import 'package:get/get.dart';
import '../../utils/attributes.dart';

class Edit_page extends StatefulWidget {
  const Edit_page({Key? key}) : super(key: key);

  @override
  State<Edit_page> createState() => _Edit_pageState();
}

class _Edit_pageState extends State<Edit_page> {

  final ScreenshotController screenshotController = ScreenshotController();

  void _saveContainerAsImage() async {
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

  int currentFontIndex = 0;
  List<String?> googleFonts = [
    GoogleFonts.roboto().fontFamily,
    GoogleFonts.lato().fontFamily,
    GoogleFonts.openSans().fontFamily,
    GoogleFonts.montserrat().fontFamily,
    GoogleFonts.quicksand().fontFamily,

  ];

  List<Color> containerColor = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
  ];

  List<Color> Fontcolors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
  ];


  @override
  Widget build(BuildContext context) {
    Quote currentQuote = Get.arguments as Quote;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back,),
        ),
        title: const Text(
          'Edit image',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Screenshot(
                  controller: screenshotController,
                  child: Container(
                    height: Get.height * 0.5,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedBackgroundColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          currentQuote.quote,
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
                  const Expanded(child: Text("Font Size")),
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
                              print(textSize);
                            });
                          },
                          child: Container(
                            height: Get.height * 0.05,
                            width: Get.width * 0.1,
                            decoration: (BoxDecoration(
                              borderRadius: BorderRadius.circular(5),

                            )),
                            child: const Icon(Icons.remove),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.03),
                        Text("$textSize"),
                        SizedBox(width: Get.width * 0.03),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (textSize <= 29) {
                                textSize = textSize + 1.0;
                              }
                              print(textSize);
                            });
                          },
                          child: Container(
                            height: Get.height * 0.05,
                            width: Get.width * 0.1,
                            decoration: (BoxDecoration(
                              borderRadius: BorderRadius.circular(5),

                            )),
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
                  const Expanded(child: Text("Font Line Space")),
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
                            decoration: (BoxDecoration(
                              borderRadius: BorderRadius.circular(5),

                            )),
                            child: const Icon(Icons.remove),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.05),
                        Text(verticalSpacing.toStringAsFixed(1)),
                        SizedBox(width: Get.width * 0.03),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              verticalSpacing += 0.1;
                            });
                          },
                          child: Container(
                            height: Get.height * 0.05,
                            width: Get.width * 0.1,
                            decoration: (BoxDecoration(
                              borderRadius: BorderRadius.circular(5),

                            )),
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
                  const Expanded(child: Text("Background Color")),
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
                                decoration:  BoxDecoration(
                                    color: Colors.grey.shade300
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Select Color"),
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
                                        itemCount: containerColor.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedBackgroundColor =
                                                containerColor[index];
                                              });
                                              Get.back();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: containerColor[index],
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
                  const Expanded(child: Text("Font Color")),
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
                                decoration:  BoxDecoration(
                                  color: Colors.grey.shade300,
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Select Color"),
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
                                                color: Fontcolors[index],
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
                  const Expanded(child: Text("Font Style")),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentFontIndex = (currentFontIndex + 1) % googleFonts.length;
                            });
                          },
                          child: Container(
                            height: Get.height * 0.05,
                            width: Get.width * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),

                            ),
                            child: const Icon(Icons.text_format_outlined),
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
                    onTap:_saveContainerAsImage,
                    child: Container(
                        height: Get.height * 0.06,
                        width: Get.width * 0.3,
                        decoration: (BoxDecoration(
                          borderRadius: BorderRadius.circular(5),

                        )),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Icon(Icons.save), Text("Save")],
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text: currentQuote.quote))
                          .then(
                            (value) => Get.snackbar(
                          "Quote",
                          "Successfully Copy",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.grey.withOpacity(0.5),
                              duration: const Duration(seconds: 3),
                              animationDuration: const Duration(seconds: 1)
                        ),
                      );
                    },
                    child: Container(
                        height: Get.height * 0.06,
                        width: Get.width * 0.3,
                        decoration: (BoxDecoration(
                          borderRadius: BorderRadius.circular(5),

                        )),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Icon(Icons.copy), Text("Copy")],
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Share.share(currentQuote.quote);
                    },
                    child: Container(
                      height: Get.height * 0.06,
                      width: Get.width * 0.3,
                      decoration: (BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      )),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Icon(Icons.share), Text("Share")],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
