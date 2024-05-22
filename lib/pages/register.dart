// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_projct/dataBase/DataBaseHandler.dart';
import 'package:flutter_projct/dataBase/UserClass.dart';
import 'package:flutter_projct/pages/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sqflite/sqflite.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyRegisterPage();
}

class _MyRegisterPage extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          
          body: Container(
            child: Center(
                    child: Container(
            color: Colors.grey[200],
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('Register',
                        style: TextStyle(fontSize: 30, color: Colors.purple)),
                    const SizedBox(
                      height: 20,
                    ),
            // Username field
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(fontSize: 20),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(100))),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please Enter Your Username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
            // Email field
                    TextFormField(
                      controller: _mailController,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(fontSize: 20),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(100))),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !EmailValidator.validate(value!)) {
                          return 'Please Enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
            // Password field
                    TextFormField(
                      controller: _passController,
                      obscureText: true,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(fontSize: 20),
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(100))),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
            
            //Save Button
                    ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple)),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            String name = _nameController.text;
                            String mail = _mailController.text;
                            String pass = _passController.text;
                            //DataBaseHandler db = DataBaseHandler();
                            Database dbClient = await DataBaseHandler.db;
                            user u = user(
                                id: null, name: name, mail: mail, pass: pass);
                            if (await user.getUserByMail(mail, dbClient) ==
                                null) {
                              user.insertUser(u, dbClient);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login()),
                              );
                            } else
                              return;
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
            // Text Button
                    Container(
                      alignment: Alignment.topLeft,
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Login()));
                          },
                          child: const Text(
                            'Already have an account ?',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.purple,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            ),
                    ),
                  ),
          )),
    );
  }
}
