import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  String defaultId = "JhyiTOrOA7XfTU9i2keV";
  Future<QuerySnapshot<Map<String,dynamic>>>categoryProducts = FirebaseFirestore.instance.collection('products').where('category',isEqualTo: "JhyiTOrOA7XfTU9i2keV").get();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Stream<QuerySnapshot> categories = FirebaseFirestore.instance.collection('categories').snapshots();
    return Column(children: [
      StreamBuilder<QuerySnapshot>(
          stream: categories,
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshots){
            return Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context,index){
                  print(snapshots.data!.docs.length);
                  return InkWell( onTap: (){
                    setState(() {
                      categoryProducts = FirebaseFirestore.instance.collection('products').where('category',isEqualTo: snapshots.data!.docs[index].id).get();
                    });
                  },
                    child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('${snapshots.data!.docs[index]['name']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 15,color: Colors.pink
                    ),),
                  ),);

              }),
            );
      }),

      SingleChildScrollView(
        child:
        FutureBuilder(
          future: categoryProducts,
        builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
          return Container(height: 200,child:
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
            //return Text('${snapshot.data!.docs[index]['name']}');
                return Container(
                  margin: EdgeInsets.only(left: 20,right: 15,top: 20,bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(offset: Offset(0,4),
                      blurRadius: 20)
                    ]
                  ),
                  child: Padding(padding: EdgeInsets.all(0),
                  child: Column(children: [
                    SizedBox(height: 10,),
                    Container(child: Text('${snapshot.data!.docs[index]['name']}',
                      style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),),),
                    SizedBox(height: 10,),
                    Container(
                    child: Image.network('${snapshot.data!.docs[index]['img']}',height: 120,),
                    )
                  ],),
                  ),
                );
          }));
        }),
      )
    ],);
  }}