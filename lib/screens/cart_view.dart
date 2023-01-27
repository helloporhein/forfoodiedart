import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forfoodie/main.dart';
import 'package:provider/provider.dart';
import '../auth/order.dart';
import '../carts/cart.dart';
import 'home.dart';
import 'location_screen.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int totalAmt = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart List'),
      ),
      body: Column(
        children: [
          ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: cart.getLength(),
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        cart.getList()[index].product.img,
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Container(
                              child: Text(
                            cart.getList()[index].product.name,
                            style: TextStyle(color: Colors.pink),
                          )),
                          Container(
                            child: Text(
                                '${cart.getList()[index].product.price}MMK'),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text('Quantity'),
                          Text('${cart.getList()[index].counter}')
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text('Ammount'),
                          Text(
                              '${cart.getList()[index].counter * cart.getList()[index].product.price}'),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  cart.deleteProduct(cart.getList()[index]);
                                });
                              },
                              child: Icon(Icons.remove_circle)),
                        ],
                      )
                    ],
                  ),
                );
              }),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${cart.totalAmt}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(
            width: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(10)),
            child: TextButton(
              onPressed: () async {
                var user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  print(user.email);
                  DocumentReference doc = await customerOrder()
                      .createCustomer(user.email!, cart.totalAmt.toString());
                  print(doc.id);
                  cart.getList().forEach((element) {
                    customerOrder()
                        .createOrder(element.counter, element.product, doc.id);
                  });
                  cart.delete();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LocationScreen(doc.id)
                  ));
                }
              },
              child: Text(
                'Checkout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
