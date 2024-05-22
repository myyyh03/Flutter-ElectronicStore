import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_projct/dataBase/DataBaseHandler.dart';
import 'package:flutter_projct/dataBase/UserClass.dart';
import 'package:flutter_projct/pages/MainScreen.dart';
import 'package:flutter_projct/pages/register.dart';
import 'package:sqflite/sqflite.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _MyLoginForm();
}

class _MyLoginForm extends State<Login> {
  Future<void> startSession(int userId) async {
    Database db = await DataBaseHandler.db;
    await db.execute(
      'CREATE TABLE IF NOT EXISTS session (userId INT PRIMARY KEY)',
    );
    await db.insert(
      'session',
      {'userId': userId},
    );
  }

  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  String ErrMsg = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
        child: Container(
          color: Colors.grey[200],
          child: Form(
              key: formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('LogIn',
                      style: TextStyle(fontSize: 30, color: Colors.purple)),
                  const SizedBox(
                    height: 20,
                  ),
//username field
                  TextFormField(
                    controller: _mailController,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      hintText: 'Mail',
                      hintStyle: TextStyle(fontSize: 20),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please Enter Your Mail";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
// Password field
                  TextFormField(
                    controller: _passController,
                    obscureText: true,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 20),
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please Enter Your Password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

// Button
                  ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple)),
                      onPressed: () async {
                        String mail = _mailController.text;
                        String pass = _passController.text;
                        Database dbClient = await DataBaseHandler.db;
                        user? u = await user.getUserByMail(mail, dbClient);
                        if (formState.currentState!.validate() &&
                            u != null &&
                            u.pass == pass) {
                          //Start your session
                          await startSession(u.id!);

                          //navigate to MainScreen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()));
                        } else {
                          setState(() {
                            ErrMsg = 'Invalid Mail or Password';
                          });
                          return;
                        }
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
// text Button
                  Container(
                    alignment: Alignment.topLeft,
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        },
                        child: const Text(
                          'Dont have an account ?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.purple,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      ErrMsg,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
        ),
      )),
    );
  }
}
