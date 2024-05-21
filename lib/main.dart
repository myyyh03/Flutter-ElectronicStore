import 'package:flutter/material.dart';
import 'package:flutter_projct/dataBase/DataBaseHandler.dart';
import 'package:flutter_projct/pages/MainScreen.dart';
import 'package:flutter_projct/pages/login.dart';
import 'package:sqflite/sqflite.dart';



Future<bool> isSessionActive()async{
  Database db = await DataBaseHandler.db;
  List<Map<String ,dynamic>> res = await db.query('sqlite_master' , where: 'name = ?' , whereArgs: ['session']);
  if(res.isEmpty)return false;
  else return true;
}




void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Check if a session is active
  bool res = await isSessionActive();

  runApp(MaterialApp(
    home: await isSessionActive() ? MainScreen() : Login(),
  ));
}



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});



//   @override
//   Future<Widget> build(BuildContext context) async{
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ;
//     )
//   }
// }
