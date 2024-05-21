import 'package:flutter/material.dart';
import 'package:flutter_projct/dataBase/DataBaseHandler.dart';
import 'package:flutter_projct/dataBase/ProductClass.dart';
import 'package:flutter_projct/lists/lists.dart';
import 'package:flutter_projct/pages/ProductDetails.dart';
import 'package:sqflite/sqflite.dart';

class Headphones extends StatelessWidget {

    Future<List<Map<String , dynamic>>> _fetchdata()async{
    Database db = await DataBaseHandler.db;
    List<product>products = await product.getCategoryProducts(3 , db);
    return List.generate(products.length, (i){
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
          title: const Text(
            'Headphones',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder( 
          future: _fetchdata(),
          builder: (context , snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductDetails(
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                snapshot.data![index]["desc"],
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${snapshot.data![index]["price"]} EGP',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });

            }else{
              return CircularProgressIndicator();
            }
            
          },
        )
            );
  }
}
