import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../contoller/controller.dart';
import '../../modals/qoutes_model.dart';

class second_page extends StatefulWidget {
  const second_page({Key? key}) : super(key: key);

  @override
  State<second_page> createState() => _second_pageState();
}

class _second_pageState extends State<second_page> {
  final QuotesController _quotesController = Get.find<QuotesController>();

  List<Color> containerColors = [];

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

  @override
  Widget build(BuildContext context) {
    QuoteModel quote = Get.arguments as QuoteModel;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(quote.category),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: quote.quotes.length,
        itemBuilder: (context, index) {
          Quote currentQuote = quote.quotes[index];
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
                              currentQuote.quote,
                              style: const TextStyle(
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
                                currentQuote.author,
                                style: const TextStyle(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: Get.height * 0.05,
                                  width: Get.width * 0.13,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.heart,
                                    color: Colors.black,
                                  ),
                                ),
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
                                  height: Get.height * 0.05,
                                  width: Get.width * 0.13,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.copy,
                                      color: Colors.black),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/edit", arguments: currentQuote)
                                      ?.then((value) {
                                    if (value != null) {
                                      setState(() {
                                        currentQuote = value;
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  height: Get.height * 0.05,
                                  width: Get.width * 0.13,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.edit,
                                      color: Colors.black),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Share.share(currentQuote.quote);
                                },
                                child: Container(
                                  height: Get.height * 0.05,
                                  width: Get.width * 0.13,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }
}
