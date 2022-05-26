import 'package:secure_messendger/utils/message_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer';

//класс для работы с базой данных
class DBProvider{
  static Database _database;

  Future<Database> get database async =>
      _database ??= await initDB();

  static DBProvider _dbProvider;
  DBProvider._createInstance();
  factory DBProvider(){
    return _dbProvider ??= DBProvider._createInstance();
  }

  Future<Database> initDB() async {
    var databaseDir = await getDatabasesPath();
    var path = databaseDir+"mobile_app.db";
    var database = await openDatabase(path, version: 1, onCreate: (db,version){
      db.execute('PRAGMA encoding = "UTF-8"');
      db.execute("""CREATE TABLE MessageOffline (
          id INTEGER PRIMARY KEY,
          title TEXT,
          message TEXT,
          fromusername TEXT
          )""");
    });
    return database;
  }
  //метод для добавления статьи в базу данных
  void insertMessage(MessageInfo messageInfo) async{
    var db = await database;
    try{
      await db.insert("MessageOffline", messageInfo.toMap());
      log("DATABASE: iniserted data: "+messageInfo.id.toString()+" "+messageInfo.title);
    }
    //При возникновении ошибки (статья с таким id уже существует) - обнвление информации в этой статье
    catch(e){
      log("DATABASE: message already exists, id:"+messageInfo.id.toString());
      await db.execute("""update MessageOffline set
          title = '"""+messageInfo.title+"""',
          message = '"""+messageInfo.message+"""',
          fromusername = '"""+messageInfo.from+"""'
          WHERE id = """+messageInfo.id.toString());
    }
  }
  //Метод для получения всех статей из базы данных
  Future <List<MessageInfo>> getAllMessages() async {
    List<MessageInfo> _articles = [];
    var db = await this.database;
    var res = await db.query("MessageOffline");
    res.forEach((element) {
      var article = MessageInfo.fromMap(element);
      _articles.add(article);
    });
    return _articles;
  }

}
