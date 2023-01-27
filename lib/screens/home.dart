import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfoodie/auth/auth.dart';
import 'package:forfoodie/auth/login_status.dart';
import 'package:forfoodie/main.dart';
import 'package:forfoodie/screens/body.dart';
import 'package:provider/provider.dart';

import '../admin/admin.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool status = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRole();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
            text: TextSpan(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                children: [
              TextSpan(
                  text: 'ForFoodie', style: TextStyle(color: Colors.white)),
              //TextSpan(text: 'Order', style: TextStyle(color: Colors.grey))
            ])),
        actions: [
          //IconButton(onPressed: (){}, icon: SvgPicture.asset(pizza_w700.png))
          IconButton(
              onPressed: () {}, icon: Image.asset('assets/pizza_w700.png'))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 2) {
              Auth().logOut();
              Provider.of<LoginStatus>(context, listen: false).setStatus(false);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ForFoodie()));
            }else if (index == 3) {
              if(this.status){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Admin();
                }));
              }
             }
          },
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'LogOut'),

            status?
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Admin'):

            BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: 'User')
          ]),
      body: const Body(),
    );
  }

  checkRole()async{
    QuerySnapshot<Map<String,dynamic>> roles = await FirebaseFirestore.instance.collection('role').where('user_id',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    if(roles.docs[0]['role'] == 'admin'){
      setState(() {
        this.status = true;
      });
    }
  }
}
