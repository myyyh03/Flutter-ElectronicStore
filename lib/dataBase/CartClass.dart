import 'package:sqflite/sqflite.dart';

class cart{
  int userID;
  int productID;

  cart({required this.userID ,required this.productID});

  static Future<void> createCartTable(Database db)async {
    await db.execute('''
      CREATE TABLE cart(
        userID INTEGER,
        productID INTEGER,
        FOREIGN KEY (userID) REFERENCES user(id),
        FOREIGN KEY (productID) REFERENCES product(id)
      )
    ''');
  }


  static Future<void> insertToCart(userID , productID , Database dbClient) async{
    cart c = new cart(userID: userID , productID: productID);
      await dbClient.insert(
        'cart',
        c.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
  }

  static Future<List<cart>> getAllCart(userID , Database dbClient) async {
    final List<Map<String , dynamic>>products = await dbClient.query(
      'cart',
      where: 'id = ?',
      whereArgs: [userID], 
    );

    return List.generate(products.length, (i){
      return cart(
        userID: products[i]['userID'],
        productID: products[i]['productID'],
      );
    });
  }


  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'productID': productID,
    };
  }


  String toString() {
    return 'cart{userID: $userID ,productID: $productID}';
  }

}