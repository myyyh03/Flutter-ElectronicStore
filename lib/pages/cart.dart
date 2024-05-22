import 'package:flutter/material.dart';
import 'package:flutter_projct/dataBase/CartClass.dart';
import 'package:flutter_projct/dataBase/DataBaseHandler.dart';
import 'package:flutter_projct/dataBase/ProductClass.dart';
//import 'package:flutter_projct/lists/lists.dart';
//import 'package:flutter_projct/pages/ProductDetails.dart';
import 'package:flutter_projct/pages/cartProductDetails.dart';
import 'package:flutter_projct/pages/login.dart';
import 'package:sqflite/sqflite.dart';

class Cart extends StatelessWidget {
  Future<List<Map<String, dynamic>>> _fetchdata() async {
    Database db = await DataBaseHandler.db;
    List<Map<String, dynamic>> u = await db.query('session');
    List<Map<String, dynamic>> mp = await db
        .query('cart', where: 'userId = ?', whereArgs: [u[0]['userId']]);
    List<int> ids = List.generate(mp.length, (index) {
      return mp[index]['productID'];
    });

    List<product> products = await product.getProductsById(ids, db);
    return List.generate(products.length, (i) {
      return {
        'id': products[i].id,
        'categoryID': products[i].categoryID,
        'name': products[i].name,
        'desc': products[i].desc,
        'longdesc': products[i].longdesc,
        'price': products[i].price,
        'image': products[i].image,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Your ',
              style:
                  TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            ),
            Text(
              'Cart',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: FutureBuilder(
          future: _fetchdata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => cartProductDetails(
                                        data: snapshot.data![index],
                                      )));
                            },
                            child: Container(
                              width: 250,
                              height: 350,
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      snapshot.data![index]['image'],
                                      height: 180,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      snapshot.data![index]["name"],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 1),
                                    Text(
                                      snapshot.data![index]["desc"],
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${snapshot.data![index]["price"]} EGP',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
// Submit Button
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 20)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.purple)),
                          onPressed: () async {
                            Database db = await DataBaseHandler.db;
                            List<Map<String, dynamic>> u = await db.query('session');
                            int id = await db.delete(
                              'cart',
                              where: 'userID = ?',
                              whereArgs: [u[0]['userId']],
                            );
                            if(id == 0){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('There is no Order to submit' , style: TextStyle(color: Colors.red),),
                                  duration: Duration(seconds: 3),
                                )
                              );
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Order submitted, An email sent with the details'),
                                  duration: Duration(seconds: 3),
                                )
                              );
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Cart()));
                          },
                          child: const Text(
                            'Submit Order',
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ))),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
