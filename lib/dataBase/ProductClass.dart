import 'package:flutter_projct/dataBase/DataBaseHandler.dart';
import 'package:sqflite/sqflite.dart';

class product {
  int id;
  int categoryID;
  String name;
  String desc;
  String longdesc;
  int price;
  String image;
  product(
      {required this.id,
      required this.categoryID,
      required this.name,
      required this.desc,
      required this.longdesc,
      required this.price,
      required this.image});

  static Future<void> createProductTable(Database db) async {
    await db.execute('''
      CREATE TABLE product(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryID INTEGER,
        name TEXT,
        desc TEXT,
        longdesc TEXT,
        price INTEGER,
        image TEXT,
        FOREIGN KEY (categoryID) REFERENCES category(id)
      )
    ''');
  }

  static Future<void> insertAllProducts(
      List<Map<String, dynamic>> products, Database db) async {
    for (Map<String, dynamic> i in products) {
      product p = product(
          id: i['id'],
          categoryID: i['categoryID'],
          name: i['name'],
          desc: i['desc'],
          longdesc: i['longdesc'],
          price: i['price'],
          image: i['image']);
      int id = await db.insert(
        'product',
        p.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      p.id = id;
    }
  }

  static Future<void> insertProduct(product p, Database db) async {
    int id = await db.insert(
      'product',
      p.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    p.id = id;
  }

  static Future<List<product>> getAllProducts(Database db) async {
    final List<Map<String, dynamic>> products = await db.query('product');
    return List.generate(products.length, (i) {
      return product(
        id: products[i]['id'],
        categoryID: products[i]['categoryID'],
        name: products[i]['name'],
        desc: products[i]['desc'],
        longdesc: products[i]['longdesc'],
        price: products[i]['price'],
        image: products[i]['image'],
      );
    });
  }

  static Future<List<product>> getProductsById(List<int> ids, Database db) async {
    List<List<Map<String, dynamic>>> productsn = [];
    
    await Future.forEach<int>(ids , (i)async{
      productsn.add(await db.query('product', where: 'id = ?', whereArgs: [i]));
    });



    return List.generate(productsn.length, (i) {
      return product(
        id: productsn[i][0]['id'],
        categoryID: productsn[i][0]['categoryID'],
        name: productsn[i][0]['name'],
        desc: productsn[i][0]['desc'],
        longdesc: productsn[i][0]['longdesc'],
        price: productsn[i][0]['price'],
        image: productsn[i][0]['image'],
      );
    });
  }

  static Future<List<product>> getCategoryProducts(
      int category_id, Database db) async {
    List<Map<String, dynamic>> products = await db
        .query('product', where: 'categoryID = ?', whereArgs: [category_id]);

    return List.generate(products.length, (i) {
      return product(
          id: products[i]['id'],
          categoryID: products[i]['categoryID'],
          name: products[i]['name'],
          desc: products[i]['desc'],
          longdesc: products[i]['longdesc'],
          price: products[i]['price'],
          image: products[i]['image']);
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryID': categoryID,
      'name': name,
      'desc': desc,
      'longdesc': longdesc,
      'price': price,
      'image': image,
    };
  }

  String toString() {
    return 'product{id: $id , categoryID: $categoryID , name: $name , desc: $desc, longdesc: $longdesc , price: $price , image: $image}';
  }
}
