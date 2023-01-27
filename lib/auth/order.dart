import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfoodie/models/product.dart';

class customerOrder{
  Future<DocumentReference> createCustomer(String email,String amt)async{
    DocumentReference doc = await FirebaseFirestore.instance.collection('customers').add({
      'email': email,
      'total': amt,
      'lat': '',
      'lon': ''
    });
    return doc;
  }

  void createOrder(int qty,Product product,String id){
    FirebaseFirestore.instance.collection('orders').add({
      'name': product.name,
      'img' : product.img,
      'price' : product.price,
      'qty' : qty,
      'customer_id' : id
    });
  }
  void deleteOrder(String id)async{
    QuerySnapshot<Map<String,dynamic>> orders =await FirebaseFirestore.instance.collection('orders').where('customer_id',isEqualTo: id).get();
    orders.docs.forEach((element) {
      FirebaseFirestore.instance.collection('orders').doc(element.id).delete();
    });
    FirebaseFirestore.instance.collection('customers').doc(id).delete();
  }

  Stream<QuerySnapshot> getCustomers()async*{
    Stream<QuerySnapshot> customers = FirebaseFirestore.instance.collection('customers').snapshots();
    yield* customers;
  }

  Future<QuerySnapshot<Map<String,dynamic>>> getOrder(String id)async{
    QuerySnapshot<Map<String,dynamic>> orders =await FirebaseFirestore.instance.collection('orders').where('customer_id', isEqualTo: id).get();
    return orders;
  }
}