import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'notemodel.dart';
class DbHelper{
  static final _databasename="logindb.db";
  static final _tablename="login";
  static final _dbversion=1;
  static final _username="username";
  static final _password="password";
  static final _phone="phone";
  DbHelper._privateConstructor();
  static final DbHelper instance=DbHelper._privateConstructor();
  static Database? _database;

  Future<Database>get database async{
    if(_database!=null)
      return _database!;
    _database=await _initDb();
    return _database!;
  }
  _initDb()async{
    String path=join(await getDatabasesPath(),_databasename);
    return await openDatabase(path,version: _dbversion,onCreate: _onCreate);
  }
  _onCreate(Database db,int version)async{
    await db.execute('''
    CREATE TABLE $_tablename (
    $_username TEXT NOT NULL,
    $_password TEXT NOT NULL,
    $_phone INTEGER PRIMARY KEY
    )
    ''');
  }
  Future<void>addData(NoteModel login)async{
    Database Db=await instance.database;
    int time=await Db.insert(_tablename, {_username:login.Username,_password:login.Password,_phone:login.Phone});

  }
  Future<List<Map<String,dynamic>>>getAllValues()async{
    Database db=await instance.database;
    return db.query(_tablename);
  }
  Future<List<Map<String,dynamic>>>CheckLogin(String username,String password)async{
    Database db=await instance.database;
    return db.query(_tablename,where:"$_username=? and $_password=?",whereArgs: [username,password]);
  }
}