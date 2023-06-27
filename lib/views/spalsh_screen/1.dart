import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class spalshscreen1 extends StatefulWidget {
  const spalshscreen1({Key? key}) : super(key: key);

  @override
  State<spalshscreen1> createState() => _spalshscreen1State();
}

class _spalshscreen1State extends State<spalshscreen1> {
  List<String> title = ["surprise","hello"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Lottie.asset(
                  'assets/splash_screen/1.json',
                  height: 300,
                  reverse: true,
                  repeat: true,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(title[index])
              ],
            );
          },
        ),
      ),
    );
  }
}
