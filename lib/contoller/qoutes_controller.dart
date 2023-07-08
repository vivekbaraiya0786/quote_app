
import 'package:get/get.dart';

import '../modals/get_qoute_model.dart';
import '../modals/qoute_databse.dart';


class GetQuotesController extends GetxController {

  GetQuotesMethod getQuotesMethod = GetQuotesMethod(getAllQuotes: Future(() => []));

  getQuotesList({required Future<List<QuotesDatabaseModel>> allQuotes}) {
    getQuotesMethod.getAllQuotes = allQuotes;
    update();
  }
}
