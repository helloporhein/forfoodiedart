import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forfoodie/auth/login_status.dart';
import 'package:forfoodie/main.dart';
import 'package:forfoodie/screens/register_screen.dart';
import 'package:provider/provider.dart';

import '../auth/auth.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.pink),
        child: Column(children: [
          SizedBox(height: 80,),
          Padding(padding: EdgeInsets.all(20),

            child: Column(children: [
              SizedBox(height: 60,),
              Center(child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 23,
              fontWeight: FontWeight.bold
              ),
              ),
              ),
              SizedBox(height: 15,),
              Center(child: Text('Please Login',style: TextStyle(color: Colors.white,fontSize: 23),),),
              SizedBox(height: 20,),

            ],),
          ),
          Expanded(child:Container(
            decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
            ),
            child: Padding(padding: EdgeInsets.all(20),
            child: SingleChildScrollView(child: Column(children: [
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(children: [
                  SizedBox(height: 20,),
                  Form(
                    key: key,
                      child: Column(children: [
                    Container(
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.orange
                      ),)),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Your Email'),
                        validator: (val){
                          if(val == null|| val.isEmpty){
                            return 'Email must not be empty';
                          }
                        },
                      ),
                    ),
                        SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.orange))),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your password'),
                            validator: (val){
                              if(val == null|| val.isEmpty){
                                return 'Password must not be empty';
                              }
                            },
                          ),
                        )
                  ],)),
                  SizedBox(height: 20,),
                  TextButton(onPressed: (){
                    //BlocProvider.of<BlocPage>(context).add(RegisterEvent());
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
                  }, child: Text('Create New Account')),
                  Container(
                    decoration: BoxDecoration(color: Colors.pink),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: OutlinedButton(onPressed: () async {

                      //await Auth().signIn(emailController.text,passwordController.text);

                      if(key.currentState!.validate()){
                        Map<String,dynamic>result = await Auth().logIn(emailController.text, passwordController.text);
                        if(result['status']){
                          Provider.of<LoginStatus>(context,listen: false).setStatus(true);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ForFoodie()));
                        } else{
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => Home()));
                        }
                      }
                    },
                        child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 23),)
                    ,),
                  )
                ],),
              )
            ],),),),
          ) )
        ],),
      ),
    );
  }

}