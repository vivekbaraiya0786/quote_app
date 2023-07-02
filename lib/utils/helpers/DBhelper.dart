import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../contoller/database_check_contoller.dart';
import '../../modals/category_database_model.dart';
import '../../modals/favourite_db_model.dart';
import '../../modals/qoute_databse.dart';
import '../../modals/qoutes_model.dart';
import '../attributes.dart';
class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  Database? db;

  Future<List<QuotesModel>> LocalJsonDataLoad() async {
    String JsonPath = "assets/json/quotes.json";
    String jsonData = await rootBundle.loadString(JsonPath);

    List decodedList = jsonDecode(jsonData);

    List<QuotesModel> Category =
    decodedList.map((e) => QuotesModel.fromJson(e)).toList();

    return Category;
  }

  // Future<List<Quote>> LocalJsonDataLoadList() async {
  //   String JsonPath = "assets/json/qoutes.json";
  //   List<Quote> quotes = [];
  //   String jsonData = await rootBundle.loadString(JsonPath);
  //
  //   List decodedList = jsonDecode(jsonData);
  //
  //   for (int i = 0; i < decodedList.length; i++) {
  //     List quote = decodedList[i]['quotes'];
  //
  //     quotes = quote.map((e) => Quote.fromJson(e)).toList();
  //   }
  //   return quotes;
  // }

  Future initDB() async {
    String dbLoaction = await getDatabasesPath();

    String path = join(dbLoaction, 'Quotes.db');

    db = await openDatabase(path, version: 1, onCreate: (db, _) async {
      String query =
          "CREATE TABLE IF NOT EXISTS category(id INTEGER, category_name TEXT NOT NULL);";

      String query2 =
          "CREATE TABLE IF NOT EXISTS quotes(id INTEGER,quote TEXT NOT NULL,author TEXT NOT NULL,favorite INTEGER NOT NULL);";

      String query3 =
          "CREATE TABLE IF NOT EXISTS favorite(id INTEGER,quote TEXT NOT NULL,author TEXT NOT NULL,favorite INTEGER NOT NULL);";

      await db.execute(query);
      await db.execute(query2);
      await db.execute(query3);
    });
  }

  Future insertCategory() async {
    await initDB();

    List<QuotesModel> Category = await LocalJsonDataLoad();
    // List<Quote> Quotes = await LocalJsonDataLoadList();

    for (int i = 0; i < Category.length; i++) {
      String query = "INSERT INTO category(id, category_name)VALUES(?,?);";
      List args = [
        Category[i].id,
        Category[i].category,
        // Category[i].categoryImage,

      ];
      int res = await db!.rawInsert(query, args);

      print(res);
    }


    // for (int i = 0; i < Quotes.length; i++) {
    //   String query2 = "INSERT INTO quotes(id,quote,author)VALUES(?,?,?);";
    //   List args2 = [
    //     Quotes[i].id,
    //     Quotes[i].quote,
    //     Quotes[i].author,
    //   ];
    //
    //   int res = await db!.rawInsert(query2, args2);
    //
    //   print("-- $res --");
    // }

    for(int i = 0; i < Category.length; i++) {
      for(int j=0; j< Category[i].quotes.length; j++) {
        String query2 =
            "INSERT INTO quotes(id,quote,author,favorite)VALUES(?,?,?,?);";
        List args = [
          Category[i].quotes[j].id,
          Category[i].quotes[j].quote,
          Category[i].quotes[j].author,
          Category[i].quotes[j].favorite
        ];
        print("${Category[i].quotes[j].id}");
        print("\n${Category[i].quotes[j].quote}");
        print("\n${Category[i].quotes[j].favorite}");

        int res = await db!.rawInsert(query2,args);
        print("-- $res --");
      }
    }
  }

  Future insertFavorite({required QuotesDatabaseModel data}) async {
    await initDB();
    String query =
        "INSERT INTO favorite(id,quote,author,favorite)VALUES(?,?,?,?);";
    List args = [
      data.id,
      data.quotes,
      data.author,
      data.favorite,
    ];

    await db!.rawInsert(query, args);
  }


  Future<List<CategoryDatabaseModel>> fatchAllCategory() async {
    await initDB();
    DataBaseCheckController dataBaseCheckController = DataBaseCheckController();

    if (data.read("isInsert") != true) {
      await insertCategory();
      print("INSERT TABLE");
      print(data.read("isInsert"));
    } else {
      print("NOT REPERT");
      print(data.read("isInsert"));
    }

    dataBaseCheckController.InsertInValue();

    String query = "SELECT * FROM category";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<CategoryDatabaseModel> allCategory =
    res.map((e) => CategoryDatabaseModel.formMap(data: e)).toList();

    return allCategory;
  }

  Future<List<QuotesDatabaseModel>> fatchAllQuotes({required int id}) async {
    await initDB();
    String query = "SELECT * FROM quotes WHERE id=?;";
    List args = [id];
    List<Map<String, dynamic>> res = await db!.rawQuery(query,args);
    List<QuotesDatabaseModel> allQuotes =
    res.map((e) => QuotesDatabaseModel.formMap(data: e)).toList();
    return allQuotes;
  }


  Future<List<FavoriteDataBaseModel>> fatchAllFavorite() async {
    await initDB();

    String query = "SELECT * FROM favorite;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<FavoriteDataBaseModel> allFavorite =
    res.map((e) => FavoriteDataBaseModel.fromMap(data: e)).toList();
    return allFavorite;
  }

  Future updateQuote({required int favorite, required String quote}) async {
    await initDB();

    String query = "UPDATE quotes SET favorite = ? WHERE quote = ?;";
    List args = [favorite, quote];

    await db!.rawUpdate(query, args);
  }

  Future updateSecondQuote(
      {required int favorite, required String quote}) async {
    await initDB();

    String query = "UPDATE quotes SET favorite = ? WHERE quote = ?;";
    List args = [favorite, quote];

    await db!.rawUpdate(query, args);
  }

  Future deleteFavorite({required String quote}) async {
    await initDB();

    String query = "DELETE FROM favorite WHERE quote = ?;";

    List args = [quote];

    await db!.rawDelete(query, args);
  }
}
