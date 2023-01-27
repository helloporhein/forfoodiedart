import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatefulWidget {
  const DiscountCard({super.key});

  @override
  _DiscountCardState createState() => _DiscountCardState();
}

class _DiscountCardState extends State<DiscountCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text('Offers & Discount', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink),
        ),
          Container(
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/bestfood/ic_best_food_1.jpeg'),
            fit: BoxFit.fill
            )
            ),
            child: Padding(padding: EdgeInsets.all(20),
            child: Row(children: [
              Expanded(child: Image.asset('assets/images/menus/ic_credit_card.png')),
              Expanded(child: RichText(text: TextSpan(children: [
                TextSpan(text: 'Get Discount of',style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold)),
                TextSpan(text: '40%',style: TextStyle(color: Colors.red,fontSize: 45,fontWeight: FontWeight.bold))
              ]),))

            ],)
          ),
          )
      ],),

    );
  }

}