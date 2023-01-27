import 'package:flutter/cupertino.dart';
import 'package:forfoodie/screens/image_slider.dart';
import 'package:forfoodie/screens/product_list.dart';
import 'package:forfoodie/screens/search_box.dart';

import 'category_list.dart';
import 'discount_cart.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();

}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          SearchBox(),
          ImageSlider(),
          CategoryList(),
          DiscountCard(),
          SizedBox(height: 30,),
          ProductList()
        ],
      ),
    );
  }

}