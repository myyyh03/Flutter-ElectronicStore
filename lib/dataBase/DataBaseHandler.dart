import 'package:flutter_projct/dataBase/CategoryClass.dart';
import 'package:flutter_projct/lists/lists.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_projct/dataBase/ProductClass.dart';
import 'package:flutter_projct/dataBase/CartClass.dart';
import 'package:flutter_projct/dataBase/UserClass.dart';

class DataBaseHandler{
    static Database? _db;
  static const String DATABASE = 'MobileStore.db';
  static const int VERSION = 1;

  static Future<Database> get db async{
    if(_db == null){
      String path = join(await getDatabasesPath(), DATABASE);
      _db = await openDatabase(path , version: VERSION ,onCreate: _onCreate , onUpgrade: _onUpgrade);
    }
    return _db!;
  }


    static _onCreate(Database db, int version)async {
    await db.execute('PRAGMA foreign_keys = ON');

    await product.createProductTable(db);
    await category.createCategoryTable(db);
    await cart.createCartTable(db);
    await user.createUserTable(db);
    
    await product.insertAllProducts(ProductList , db);
    await category.insertAllCategories(CategoryList , db);
  }

  static _onUpgrade(Database db, int oldVersion, int newVersion)async {
    await db.execute('drop table product');
    await db.execute('drop table category');
    await _onCreate(db , newVersion);
  }
}