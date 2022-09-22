import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_log_out_mechanism/screens/home_screen/page/home_page.dart';
import 'package:login_log_out_mechanism/screens/home_screen/page/sign_up_screen.dart';
import 'package:login_log_out_mechanism/screens/modals/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkBoxValue = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/vactor1.webp",
                height: 230,
                width: 230,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            isEmailValid = true;
                            setState(() {});
                          } else {
                            return "Enter valid Email";
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            isPasswordValid = true;
                            setState(() {});
                          } else {
                            return "Enter valid Email";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: checkBoxValue,
                    onChanged: (val) {
                      setState(() {
                        checkBoxValue = val!;
                      });
                    },
                  ),
                  Text("Remember me"),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text(
                      'Forgot Password',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 200,
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();

                    String? data = prefs.getString("signUp");

                    log("${data}", name: "Data");

                    List<dynamic> decodedData = jsonDecode(data!);

                    List<SignUp> mySignUpData = decodedData.map((e) => SignUp.fromMap(data: e)).toList();

                    log("${mySignUpData}", name: "signUpData");

                    // String? email = prefs.getString("email");
                    // String? password = prefs.getString("password");

                    for (int i = 0; i < mySignUpData.length; i++) {
                      if (true) {
                        if (emailController.text == mySignUpData[i].email && passwordController.text == mySignUpData[i].password) {
                          if (checkBoxValue) {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setBool("checkedBoxValue", true);
                            Navigator.pushReplacementNamed(context, "/");
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          }
                        }
                        else {
                          log(mySignUpData[i].email, name: "Email");
                          log(mySignUpData[i].password, name: "Password");

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Enter valid email or password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                      else {}
                    }

                    print(emailController.text);
                    print(passwordController.text);
                  },
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
