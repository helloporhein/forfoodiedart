import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import 'detail_screen.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  Stream<QuerySnapshot> products = FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: products,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshots){
        return GridView.builder(
          //scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshots.data!.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            childAspectRatio: 1.1
            ),
            itemBuilder: (BuildContext context,index){
                return InkWell(
                  onTap: (){
                    Product product = Product(
                        snapshots.data!.docs[index].id,
                        snapshots.data!.docs[index]['name'], snapshots.data!.docs[index]['price'],
                        snapshots.data!.docs[index]['description'],snapshots.data!.docs[index]['img'], snapshots.data!.docs[index]['shop']);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(snapshots.data!.docs[index].id,product)));
                  },
                  child: SingleChildScrollView(child:
                Column(children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),

                      child: Image.network('${snapshots.data!.docs[index]['img']}',scale: 2*2,)),
                  Container(child: Column(children: [
                    Text('${snapshots.data!.docs[index]['name']}',style: const TextStyle(
                        color: Colors.pink,fontWeight: FontWeight.bold),),
                    Text('${snapshots.data!.docs[index]['price']} MMK',style: const TextStyle(
                        color: Colors.pink,fontWeight: FontWeight.bold),
                    ),
                  ]),
                    //
                    //

                  )],),),);

            });
      },),
    );
  }

}