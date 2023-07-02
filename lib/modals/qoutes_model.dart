import 'dart:typed_data';

class QuotesModel {
  int id;
  String category;
  // Uint8List? categoryImage;
  List<Quote> quotes;

  QuotesModel({
    required this.id,
    required this.category,
    // required this.categoryImage,
    required this.quotes,
  });

  factory QuotesModel.fromJson(Map<String, dynamic> json) => QuotesModel(
    id: json["id"],
    category: json["category"],
    // categoryImage: json["quotes-image"],
    quotes: List<Quote>.from(json["quotes"].map((x) => Quote.fromJson(x))),
  );

}

class Quote {
  int? id;
  String quote;
  String author;
  int? favorite;

  Quote({
    this.id,
    required this.quote,
    required this.author,
    this.favorite,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    id: json["id"],
    quote: json["quote"],
    author: json["author"],
    favorite: json["favorite"],
  );
}
