import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forfoodie/admin/show_order.dart';

import '../auth/order.dart';
import '../screens/user_location.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel'),),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: customerOrder().getCustomers(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshots){
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshots.data!.docs.length,
                itemBuilder: (context,index){
              return Card(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                  child: Text('${snapshots.data!.docs[index]['email']}',style: TextStyle(fontWeight: FontWeight.bold),),),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ShowOrder(snapshots.data!.docs[index].id,snapshots.data!.docs[index]['total']);
                  }));
                }, icon: Icon(Icons.remove_red_eye,color: Colors.pink,)),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return UserLocation(snapshots.data!.docs[index]['lat'],snapshots.data!.docs[index]['lon']);}));

                }, icon: Icon(Icons.pin_drop,color: Colors.pink,)),
                IconButton(onPressed: (){
                  customerOrder().deleteOrder(snapshots.data!.docs[index].id);
                }, icon: Icon(Icons.delete,color: Colors.pink,)),
              ],),);
            });
        },),
      ),
    );
  }

}