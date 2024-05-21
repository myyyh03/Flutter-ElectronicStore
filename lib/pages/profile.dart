import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_projct/dataBase/DataBaseHandler.dart';
import 'package:flutter_projct/pages/login.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_projct/dataBase/UserClass.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isObsecurePassword = true;

  Future<Map<String , dynamic>> _fetchdata()async{
    Database db = await DataBaseHandler.db;
    List<Map<String , dynamic>> idLis = await db.query('session');
    int id = idLis[0]['userId'];

    user? u = await user.getUserByID(id, db);

    Map<String ,dynamic>mp = {
      'id' : u!.id,
      'name': u.name,
      'mail': u.mail,
      'pass': u.pass,
    };
    return mp;
  }

  @override
  build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Your profile'),
            backgroundColor:  Colors.purple,
          ),
          body: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: FutureBuilder(
              // onTap: () {
              //   FocusScope.of(context).unfocus();
              // },
              future: _fetchdata(),
              builder:(context , snapshot){
                if(snapshot.hasData){
                  return  ListView(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border: Border.all(width: 4, color: Colors.white),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwmLcG1vLtL7UL-KRmLrzoFlqWlsVG8_cJShmGlWYhZXSiVDhM&s'),
                                ),
                              ),
                            ),
                            Positioned(
                              width: 0,
                              height: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Colors.white,
                                    ),
                                    color:  Colors.purple),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                      BuildTextField('${snapshot.data!['name']}', 'Name', false),
                      BuildTextField('${snapshot.data!['mail']}', 'Email', false),
                      BuildTextField('${snapshot.data!['pass']}','Password' , true),
                      SizedBox(height: 20,),
                      ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                                  backgroundColor: MaterialStateProperty.all(Colors.purple)),
                              onPressed: () async {
                                Database db = await DataBaseHandler.db;
                                await db.execute('DROP TABLE session');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                                },
                              child: const Text(
                                'Log Out',
                                style: TextStyle(color: Colors.white, fontSize: 19),
                              )),
                    ],
                  );
              }else{
                return CircularProgressIndicator();
              }
              }
            ),
          ),
        ),
      );
  }

  Widget BuildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        readOnly: true,
        obscureText: isPasswordTextField ? true : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      isObsecurePassword = !isObsecurePassword;
                    });
                  },
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: placeholder,
          labelStyle: TextStyle(fontSize: 14 , color: Colors.purple),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: labelText,
          hintStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}


