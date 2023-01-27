import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.grey)
      ),
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 3),
      child: TextField(
        onChanged: (val){
          
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          //icon: Image.asset('assets/pizza_w700.png'),
          hintText: 'Search Here'
        ),
      ),
    );
  }
  
}