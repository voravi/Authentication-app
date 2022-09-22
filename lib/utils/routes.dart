import 'package:flutter/cupertino.dart';
import 'package:login_log_out_mechanism/screens/home_screen/page/home_page.dart';


import '../screens/home_screen/page/login_page.dart';
import 'appRoutes.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes().homePage: (context) => HomePage(),
  AppRoutes().loginPage: (context) => LoginPage(),
};
