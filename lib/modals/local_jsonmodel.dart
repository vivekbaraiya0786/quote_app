
import 'dart:typed_data';

import 'package:quotes_app/modals/qoutes_model.dart';

class LocalJsonModel {
  String jsonData;
  // Uint8List? categoryImage;
  List<QuotesModel> Quotes;

  LocalJsonModel({
    required this.jsonData,
    // this.categoryImage,
    required this.Quotes,
  });
}
