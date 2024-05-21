import 'package:flutter/material.dart';
import 'package:flutter_projct/dataBase/DataBaseHandler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_projct/dataBase/CartClass.dart';

class ProductDetails extends StatefulWidget {
  final data;

  const ProductDetails({super.key, this.data});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
                onPressed: () async {
                  Database db = await DataBaseHandler.db;
                  List<Map>u = await db.query('session');
                  int userID = u[0]['userId']; 
                  await cart.insertToCart(userID , widget.data['id'] , db);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Product Added to your cart'),
                      duration: Duration(seconds: 3),
                    )
                  );
                },
                child: Text(
                  'Add to card',
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20)),
                    backgroundColor: MaterialStateProperty.all(Colors.purple)),
              )
            ],
          ),
        ));
  }
}
