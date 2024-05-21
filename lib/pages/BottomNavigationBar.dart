import 'package:flutter/material.dart';
import 'package:flutter_projct/pages/MainScreen.dart';
import 'package:flutter_projct/pages/cart.dart';
import 'package:flutter_projct/pages/profile.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  State<MyBottomNavigationBar> createState() => _NavigationBar();
}

class _NavigationBar extends State<MyBottomNavigationBar> {
  int state = 0;
  GlobalKey<State> selected = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: state,
        selectedItemColor: Colors.purple,
        onTap: (value) {
          setState(() {
            state = value;
          });
          switch (state) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            case 1:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
            case 2:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 30,
              ),
              label: '.'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              label: '.'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: '.')
        ]);
  }
}
