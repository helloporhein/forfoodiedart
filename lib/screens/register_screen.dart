import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forfoodie/auth/login_status.dart';
import 'package:provider/provider.dart';
import '../auth/auth.dart';
import '../main.dart';
import 'home.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.pink),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      'Please Create New Account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Form(
                                child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.orange))),
                                  child: TextFormField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter Your Name'),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Name must not be empty';
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.orange))),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter your email'),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Email must not be empty';
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.orange))),
                                  child: TextFormField(
                                    controller: passwordController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter Your Password'),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Password must not be empty';
                                      }
                                    },
                                  ),
                                )
                              ],
                            )),
                            const SizedBox(
                              height: 20,
                            ),
                            TextButton(
                                onPressed: () {
                                  //BlocProvider.of<BlocPage>(context).add(LoginEvent());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                                child: const Text('Please Login')),
                            Container(
                              decoration:
                                  const BoxDecoration(color: Colors.pink),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: OutlinedButton(
                                onPressed: () async {

                                  if (key.currentState!.validate()) {
                                    await Auth().signUp(emailController.text, passwordController.text);
                                    Map<String, dynamic> register = await Auth().register(emailController.text,passwordController.text);
                                    if (register['status']) {
                                      Provider.of<LoginStatus>(context,
                                              listen: false)
                                          .setStatus(true);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForFoodie()));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    }
                                  }
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
