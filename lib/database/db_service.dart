import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/news_model.dart';
import '../model/user_model.dart';

class DataBaseService{
  static final DataBaseService _instance = DataBaseService._privateConstructor();

  factory DataBaseService() {
    return _instance;
  }

  DataBaseService._privateConstructor();
  static const String dbName = 'news.db';
  static const String dbName2 = 'savedNews.db';
  static const int version = 1;
  static const String tableUser = 'user';
  static const String tableUserNews = 'savednews';
  static const String cUserName = 'user_name';
  static const String cPassword = 'password';
  static const String cEmail = 'email';
  static const String cPhone = 'phone';

  static Future<Database> _openDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return openDatabase(path, version: version, onCreate: _onCreate);
  }

  static Future<Database> _openDatabaseNews() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName2);
    return openDatabase(path, version: version, onCreate: _oncreateDB);
  }

  static Future<void> _oncreateDB(Database db, int version) async {
    await db.execute("CREATE TABLE $tableUserNews ("
        " id INTEGER PRIMARY KEY AUTOINCREMENT, "
        " username TEXT, "
        " title TEXT, "
        " description TEXT, "
        " url TEXT, "
        " urlToImage TEXT, "
        " author TEXT, "
        " publishedAt TEXT, "
        " content TEXT"
        ")");
  }

  static Future<void> _onCreate(Database db, int version) async{
    await db.execute("CREATE TABLE $tableUser ("
        " $cUserName TEXT, "
        " $cEmail TEXT,"
        " $cPassword TEXT,"
        " $cPhone TEXT, "
        " PRIMARY KEY ($cEmail)"
        ")");
  }

  static Future<int> saveData(String user_name, String password, String email, String phone) async{
    final db = await _openDatabase();
    final data = {
      'user_name': user_name,
      'password': password,
      'email': email,
      'phone': phone,
    };
    return await db.insert('user', data);
  }

  Future<UserModel> validateCredentials(String userName, String pass) async{
    final db = await _openDatabase();
    var res = await db.rawQuery("SELECT * FROM $tableUser WHERE $cUserName = ? AND $cPassword = ?",
      [userName, pass],);

    if (res.length > 0){
      return UserModel.fromMap(res.first);
    }
    else {
      throw Exception('Invalid login credentials');
    }
  }

  static Future<int> insertNewsForUser(NewsModel news, String name) async {
    final db = await _openDatabaseNews();
    final data = {
      'username': name,
      'title': news.newsTitle,
      'description': news.newsDes,
      'url': news.newsUrl,
      'urlToImage': news.newsImg,
      'author': news.newsAuthor,
      'publishedAt': news.newsDate,
      'content': news.newsContent,
    };
    return await db.insert('savednews', data);
  }

  static Future<List<NewsModel>> retrieveNewsForUser(String username) async {
    final db = await _openDatabaseNews();
    final maps = await db.query('savednews', where: 'username = ?', whereArgs: [username]);
    return List.generate(maps.length, (i) {
      return NewsModel.fromMap(maps[i]);
    });
  }

  static Future<UserModel> getUserData(String userName) async {
    final db = await _openDatabase();
    var res = await db.rawQuery(
      "SELECT * FROM $tableUser WHERE $cEmail = ?",
      [userName],
    );
    if (res.isNotEmpty) {
      return UserModel.fromMap(res.first);
    } else {
      throw Exception('User not found.');
    }
  }

  static Future<int> updateData(String userName, String pass, String mail, String phone) async{
    final db = await _openDatabase();
    var dataToUpdate = {
      'password': pass,
      'email': mail,
      'phone': phone,
    };
    return await db.update(tableUser, dataToUpdate,
      where: "$cEmail = ?",
      whereArgs: [userName],
    );
  }

  static Future<int> deleteSavedNews(String userName, String title) async{
    final db = await _openDatabaseNews();
    return await db.delete(
      'savednews',
      where: "username = ? AND title = ?",
      whereArgs: [userName, title],
    );
  }

}