import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:login_log_out_mechanism/screens/home_screen/page/login_page.dart';
import 'package:login_log_out_mechanism/screens/modals/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

List<SignUp> signUps = [];

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isUserNameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isConfirmPasswordValid = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool checkBoxValue = false;

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
                "assets/images/vactor2.webp",
                height: 230,
                width: 230,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign up',
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
                        controller: usernameController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            isUserNameValid = true;
                            setState(() {});
                          } else {
                            return "Enter valid username";
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
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
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            isPasswordValid = true;
                            setState(() {});
                          } else {
                            return "Enter valid Password";
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: confirmPasswordController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                        ),
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            isConfirmPasswordValid = true;
                            setState(() {});
                          } else {
                            return "Enter same password";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: 200,
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (fullNameValidate(usernameController.text) == "Details Saved" && validateEmail(emailController.text) == "Details Saved") {
                        if (passwordController.text.length >= 6 &&
                            confirmPasswordController.text.length >= 6 &&
                            confirmPasswordController.text == passwordController.text) {


                          signUps.add(
                            SignUp(
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text,
                            ),
                          );


                          String jsonData = jsonEncode(signUps);

                          log(jsonData,name: "JsonData");

                           SharedPreferences prefs = await SharedPreferences.getInstance();

                           prefs.setString("signUp", jsonData);

                          // await prefs.setString("username", usernameController.text);
                          // await prefs.setString("email", emailController.text);
                          // await prefs.setString("password", passwordController.text);
                          // await prefs.setString("confirmPassword", confirmPasswordController.text);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Sign up success",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() {});

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Enter valid Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Enter valid email",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                    } else {
                      log("${formKey.currentState!.validate()}", name: "Validation");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Enter valid values",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    }

                    log(usernameController.text, name: "Username");
                    log(emailController.text, name: "Email");
                    log(passwordController.text, name: "Password");
                    log(confirmPasswordController.text, name: "Confirm Password");
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
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
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

String fullNameValidate(String fullName) {
  String patttern = r'^[a-z A-Z,.\-]+$';
  RegExp regExp = RegExp(patttern);
  if (fullName.isEmpty) {
    return 'Please enter full name';
  } else if (!regExp.hasMatch(fullName)) {
    return 'Please enter valid full name';
  }
  return "Details Saved";
}

String validateEmail(String email) {
  const String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final RegExp regex = RegExp(pattern);
  if (email.isEmpty || !regex.hasMatch(email)) {
    return 'Invalid email';
  } else {
    return "Details Saved";
  }
}
