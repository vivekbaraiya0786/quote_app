
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';

import '../modals/qoute_databse.dart';

//home page
final scaffoldKey = GlobalKey<ScaffoldState>();
List<String> imagePaths = [
  "assets/images/birthday.png",
  "assets/images/work.png",
  "assets/images/Good morning.png",
  "assets/images/love.png",
  "assets/images/attitude.png",
  "assets/images/relationship.png",
  "assets/images/life.png",
  "assets/images/happy.png",
  "assets/images/sad.png",
  "assets/images/motivation.png",
  "assets/images/wife.png",
  "assets/images/time.png",
  "assets/images/husband.png",
  "assets/images/inspristonal.png",
  "assets/images/success.png",
  "assets/images/friendship.png",
  "assets/images/art.png",
  "assets/images/annevasary.png",
  "assets/images/critshmas.png",
  "assets/images/dream.png",
  "assets/images/failure.png",
  "assets/images/funny.png",
  "assets/images/god.png",
  "assets/images/jelosuly.png",
  "assets/images/meditation.png",
  "assets/images/Nature.png",
  "assets/images/new year.png",
  "assets/images/philosophy.png",
  "assets/images/thankyou.png",
  "assets/images/valentine day.png",
  "assets/images/Good Night.png",
  "assets/images/social.png",
];


//second page

List<Color> containerColors = [];

//editpage

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

List<String> imageList = [
  "assets/continer_images/q1.jpeg",
  "assets/continer_images/q2.jpeg",
  "assets/continer_images/q3.jpeg",
  "assets/continer_images/q4.jpeg",
  "assets/continer_images/q5.jpeg",
  "assets/continer_images/q6.jpeg",
  "assets/continer_images/q7.jpeg",
  "assets/continer_images/q8.jpeg",
  "assets/continer_images/q9.jpeg",
  "assets/continer_images/q10.jpeg",
];
int currentImageIndex = 0;

Color selectedBackgroundColor = Colors.grey;
bool showImages = false;

var textSize = 14.0;
var verticalSpacing = 1.0;
var textLineSpace = 1.0;
Color selectedFontColor = Colors.white;

 ScreenshotController screenshotController = ScreenshotController();


 //other

final data = GetStorage();

Future<List<QuotesDatabaseModel>>? getAllQuotes;