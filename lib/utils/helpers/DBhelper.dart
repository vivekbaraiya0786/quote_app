
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper dbHelper = DatabaseHelper._();
  static Database? db;

  Future<void> initDB() async {


    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'quotes.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String query = '''
        CREATE TABLE IF NOT EXISTS quotes (
          id INTEGER PRIMARY KEY,
          category TEXT,
          image TEXT,
          quote TEXT,
          author TEXT
        );
      ''';
        await db.execute(query);
      },
    );
  }

  Future<int> insertQuote({required String category, required String image, required String quote, required String author}) async {
    await initDB();

    String query = '''
    INSERT INTO quotes(category, image, quote, author)
    VALUES (?, ?, ?, ?);
  ''';
    List args = [category, image, quote, author];
    int res = await db!.rawInsert(query, args); // return pk => inserted record's id

    return res;
  }

   Future<List<Map<String, dynamic>>> fetchALlCategories()async{
      await initDB();
      String query = "SELECT * FROM quotes;";
        List<Map<String, dynamic>> res =await db!.rawQuery(query);  //List<Map<String, dynamic>>
        return res;
      }
}


