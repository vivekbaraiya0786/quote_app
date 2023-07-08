

import 'package:quotes_app/modals/qoute_databse.dart';

class GetQuotesMethod {
  Future<List<QuotesDatabaseModel>> getAllQuotes;

  GetQuotesMethod({
    required this.getAllQuotes,
  });
}
