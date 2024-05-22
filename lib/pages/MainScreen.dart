import 'package:flutter/material.dart';
import 'package:flutter_projct/categoryPages/headphones.dart';
import 'package:flutter_projct/categoryPages/mobiles.dart';
import 'package:flutter_projct/categoryPages/watches.dart';
import 'package:flutter_projct/dataBase/DataBaseHandler.dart';
import 'package:flutter_projct/dataBase/ProductClass.dart';
import 'package:flutter_projct/lists/lists.dart';
import 'package:flutter_projct/pages/BottomNavigationBar.dart';
import 'package:flutter_projct/categoryPages/Laptops.dart';
import 'package:flutter_projct/pages/ProductDetails.dart';
//import 'package:flutter_projct/lists/results.dart';
import 'package:sqflite/sqflite.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MyMainScreen();
}

class _MyMainScreen extends State<MainScreen> {
  Future<List<Map<String, dynamic>>> _fetchdata() async {
    Database db = await DataBaseHandler.db;
    List<product> products = await product.getAllProducts(db);
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          bottomNavigationBar: MyBottomNavigationBar(),
          appBar: AppBar(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.shop),
                Text(
                  '  Electronics ',
                  style: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Store',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchdata(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: CategoryList.length,
                          itemBuilder: (context, i) {
                            return Container(
                                child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.purple[200],
                                          borderRadius:
                                              BorderRadius.circular(90)),
                                      padding: EdgeInsets.all(15),
                                      child: InkWell(
                                        onTap: () {
                                          switch (i) {
                                            case 0:
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Laptops()));
                                            case 1:
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Mobiles()));
                                            case 2:
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Headphones()));
                                            case 3:
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Watches()));
                                          }
                                        },
                                        child: Icon(
                                          CategoryList[i]["icon"],
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      CategoryList[i]['name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                )
                              ],
                            ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
//Results
                      const Text(
                        'Results',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                      GridView.builder(
                        itemCount: snapshot.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, mainAxisExtent: 330.0),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                        data: snapshot.data![index],
                                      )));
                            },
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    width: 300,
                                    color: Colors.grey[200],
                                    child: Image.asset(
                                      snapshot.data![index]["image"],
                                      height: 150,
                                      fit: BoxFit.fill,
                                    ),
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
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '${snapshot.data![index]["price"]} EGP',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ));
  }
}
