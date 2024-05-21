import 'package:sqflite/sqflite.dart';

class user {
  int? id;
  String name;
  String mail;
  String pass;
  user(
      {required this.id,
      required this.name,
      required this.mail,
      required this.pass});

  static Future<void> createUserTable(Database db) async {
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        mail TEXT,
        pass TEXT
      )
    ''');
  }

  static Future<void> insertUser(user u, Database db) async {
    int id = await db.insert(
      'user',
      u.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    u.id = id;
  }

  static Future<user?> getUserByID(int id, Database db) async {
    final List<Map<String, dynamic>> mp = await db.query(
      'user',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (mp.isNotEmpty){
      return user(
          id: mp[0]['id'],
          name: mp[0]['name'],
          mail: mp[0]['mail'],
          pass: mp[0]['pass']);
    }
    return null;
  }

  static Future<user?> getUserByMail(String Mail, Database db) async {
    final List<Map<String, dynamic>> mp = await db.query(
      'user',
      where: 'mail = ?',
      whereArgs: [Mail],
      limit: 1,
    );
    if (mp.isEmpty) return null;
    return user(
        id: mp[0]['id'],
        name: mp[0]['name'],
        mail: mp[0]['mail'],
        pass: mp[0]['pass']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mail': mail,
      'pass': pass,
    };
  }

  String toString() {
    return 'user{id: $id , name: $name , mail: $mail , pass: $pass}';
  }
}
