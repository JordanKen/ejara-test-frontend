import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:money/ui/features/authentification/login_screen.dart';
import 'package:money/ui/features/authentification/register_screen.dart';



class Routes {
  Routes._();

  //static variables
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String onboarding = '/onboarding';


  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    register: (BuildContext context) => RegisterScreen(),

  };
}


