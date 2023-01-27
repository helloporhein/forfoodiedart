import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth{

  Future<Map<String,dynamic>>register(String email,String password) async {
    Map<String,dynamic> register = {'status':false};

    try{
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      register['status'] = true;
      FirebaseFirestore.instance.collection('role').add({
        'role': '',
        'user_id': user.user!.uid
      });
    }catch(e){

    }
    return register;
   }
   Future<Map<String,dynamic>>logIn(String email,String password) async {
    Map<String,dynamic> result = {'status':false};

    try{
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      result['status'] = true;
    }catch(e){

    }
    return result;
  }
   signUp(String email,String password) async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
   }
  signIn(String email,String password) async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

   logOut(){
    FirebaseAuth.instance.signOut();
   }


}