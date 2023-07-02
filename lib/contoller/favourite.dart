import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../modals/qoutes_model.dart';

class QuoteController extends GetxController {
  var favoriteQuotes = <Quote>[].obs;

  void toggleFavorite(Quote quote) {
    if (quote.isFavorite) {
      favoriteQuotes.remove(quote);
    } else {
      favoriteQuotes.add(quote);
    }
    quote.isFavorite = !quote.isFavorite;
  }
}
