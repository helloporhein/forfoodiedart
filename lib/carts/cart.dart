import 'package:flutter/cupertino.dart';
import 'package:forfoodie/carts/cart_product.dart';

class Cart extends ChangeNotifier{
  List<CartProduct> cartProduct = [];
  dynamic totalAmt = 0;

  add(CartProduct cartPro){
    this.cartProduct.add(cartPro);
    totalAmt += cartPro.counter * cartPro.product.price;
    notifyListeners();
  }
  deleteProduct(CartProduct pro){
    this.cartProduct.forEach((element) {
      if(element.product.id == pro.product.id) {
        totalAmt -= element.product.price * element.counter;
        this.cartProduct.remove(element);
      }
    });
    notifyListeners();
  }
  List<CartProduct>getList(){
    return cartProduct;
  }
  delete(){
    return cartProduct.clear();
  }

  getLength(){
    return this.cartProduct.length;
  }

  has(CartProduct pro){
    int status = 0;
    this.cartProduct.forEach((element) {
      if(element.product.id == pro.product.id){
        status = 1;
      }
    });
    if(status == 1){
      return true;
    }
    return false;
  }

  int getCount(CartProduct pro) {
    int counter = 0;
    this.cartProduct.forEach((element) {
      if(element.product.id == pro.product.id){
       counter = element.counter;
      }
    });
    return counter;
  }

  updateProduct(CartProduct pro,int count){
    this.cartProduct.forEach((element) {
      if(element.product.id == pro.product.id){

        totalAmt -= element.counter * element.product.price;
        totalAmt += pro.product.price * count;
        element.counter = count  ;
      }
    });
    notifyListeners();
  }
}