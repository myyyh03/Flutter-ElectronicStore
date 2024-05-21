import 'package:sqflite/sqflite.dart';

class category{
  int id;
  String name;

  category({required this.id , required this.name});

  static Future<void> createCategoryTable(Database db)async {
        await db.execute("CREATE TABLE category(id INTEGER PRIMARY KEY, name varchar(20))");
  }

  static Future<void> insertAllCategories(List<Map<String , dynamic>> categories , Database db) async {
    for(Map<String , dynamic> i in categories){
      category t = category(id:i['id'], name: i['name']);
      await db.insert(
        'category',
        t.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }



static Future<void> insertCategory(category c , Database db) async {
      await db.insert(
        'category',
        c.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,

    };
  }


String toString() {
    return 'type{id: $id ,name: $name}';
  }

  
}