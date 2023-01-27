import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../carts/cart.dart';
import '../carts/cart_product.dart';
import '../models/product.dart';
import 'cart_view.dart';

class DetailScreen extends StatefulWidget {

  String id;
  Product product;
  DetailScreen(this.id,this.product);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int counter = 0;
  int updateCounter = 0;
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: const Text('Product Detail'),
    actions: [
      IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CartView()));
      }, icon: Row(children: [
        Text('${cart.getLength()}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        Icon(Icons.shopping_bag,color: Colors.white,),

      ],))
    ],),
    body: Column(children: [
      Image.network(widget.product.img,height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,fit: BoxFit.fill
      ),

      Expanded(
        child: SingleChildScrollView(child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.pink,borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        )),
        child: Column(children: [
          Row(children: [
            Icon(Icons.location_on,color: Colors.white),
            Expanded(child: Padding(padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Column(children: [
                Text(widget.product.name,style: TextStyle(color: Colors.white,fontSize: 20,
                ))
              ],),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Colors.white),
                width: 50,
                height: 50,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('${widget.product.price}',style: TextStyle(color: Colors.pink),),
                  Text('MMK',style: TextStyle(color: Colors.pink))
                ],),
              )

            ])
            ))
          ],),
          SizedBox(height: 20,),
          Text(widget.product.description,style: TextStyle(color: Colors.white)),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            IconButton(icon: Icon(Icons.remove_circle),onPressed:() {
              if(this.counter !=0){
                setState(() {
                  this.counter--;
                  this.updateCounter--;
                });
              }
              if(this.updateCounter + cart.getCount(CartProduct(this.counter, widget.product))!= 0 ) {
                setState(() {
                  this.updateCounter--;
                });
              }
            },),
            cart.has(CartProduct(this.counter,widget.product))?

            Text('${updateCounter + cart.getCount(CartProduct(this.counter, widget.product)) }',style: TextStyle(color: Colors.white,fontSize: 20),):
            Text('${counter}',style: TextStyle(color: Colors.white,fontSize: 20),),
            IconButton(onPressed: (){
              setState(() {
                this.counter++;

              });
              if(cart.has(CartProduct(this.counter, widget.product))){
                setState(() {
                  this.updateCounter++;
                });
              }

            }, icon: Icon(Icons.add_circle),)
          ],),

          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
              width: MediaQuery.of(context).size.width * 0.8,
          child: InkWell(
            onTap: (){
              CartProduct cartProduct = CartProduct(this.counter,widget.product);
              if(cart.has(cartProduct)){
                cart.updateProduct(cartProduct, updateCounter + cart.getCount(CartProduct(this.counter, widget.product)));
                setState(() {
                  updateCounter = 0;
                });
              }else{
                cart.add(cartProduct);
              }
            },
              child:
          Padding(padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            //SvgPicture.assets('assets/icons/bag.svg')
            Icon(Icons.shopping_bag),
            Container(width: 20,),
            Text('Order Now',style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 18),)

          ],),
          )))
        ],),
      ),
      ),
      )
    ],),
    );
  }

}