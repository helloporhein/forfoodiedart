import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forfoodie/auth/order.dart';

class ShowOrder extends StatefulWidget {
  String id;
  String amt;
  ShowOrder(this.id,this.amt);
  //const ShowOrder({Key? key}) : super(key: key);

  @override
  _ShowOrderState createState() => _ShowOrderState();
}

class _ShowOrderState extends State<ShowOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: customerOrder().getOrder(widget.id),
                builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        return Card(child:
                        Row(children: [
                          Image.network(
                            snapshot.data!.docs[index]['img'],width: 100,height: 100,),
                          Column(children: [
                            SizedBox(width: 20,),
                            Container(child: Text(
                              snapshot.data!.docs[index]['name'],style: TextStyle(
                                color: Colors.pink),),),
                            Container(child: Text('${snapshot.data!.docs[index]['price']} MMK'),)
                          ],),
                          SizedBox(width: 20,),
                          Column(children: [
                            Text('Qty'),
                            Text('${snapshot.data!.docs[index]['qty']}')
                          ],),
                          SizedBox(width: 20,),
                          Column(children: [
                            Text('Amount'),
                            Text('${snapshot.data!.docs[index]['qty'] * snapshot.data!.docs[index]['price'] }')
                          ],)
                        ],),);

                      });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              //SizedBox(width: 20,),
              Text('Total Amount',style: TextStyle(color: Colors.pink,fontWeight:  FontWeight.bold),),
              Text('${widget.amt} MMK',style: TextStyle(fontWeight: FontWeight.bold),)
            ],)
          ],
        )

      ),
    );
  }
}
