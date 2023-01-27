import 'package:flutter/cupertino.dart';

class LoginStatus extends ChangeNotifier{
  bool status = false;

  setStatus(bool val){
    this.status = val;
  }

  getStatus(){
    return this.status;
  }
}