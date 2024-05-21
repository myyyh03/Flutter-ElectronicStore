import 'package:flutter/material.dart';
import 'package:flutter_projct/dataBase/DataBaseHandler.dart';
import 'package:flutter_projct/pages/MainScreen.dart';
import 'package:flutter_projct/pages/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_projct/dataBase/CartClass.dart';

class cartProductDetails extends StatefulWidget {
  final data;

  const cartProductDetails({super.key, this.data});

  @override
  State<cartProductDetails> createState() => _cartProductDetailsState();
}

class _cartProductDetailsState extends State<cartProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '  Product ',
                style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Text(
                'Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(widget.data['image']),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.data['longdesc'],
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${widget.data['price']} EGP',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.purple),
              ),
              const SizedBox(
                height: 8,
              ),
                                ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple)),
                      onPressed: ()async {
                        Database db = await DataBaseHandler.db;
                        db.delete(
                          'cart',
                          where: 'productID = ?',
                          whereArgs: [widget.data['id']],
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder:  (context) => MainScreen()));
                      },
                      child: const Text(
                        'Remove from Cart',
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      )),              
            ],
          ),
        ));
  }
}
