import 'package:GroceryApp/src/screens/landingpage.dart';
import 'package:GroceryApp/src/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

class FluroRouter {

  static Router router = Router();

  static Handler _loginHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => LoginPage());
  static Handler _landingHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => LandingPage());
  
  static void setupRouter() {

    router.define(
      'loginPage',
      handler: _loginHandler,
    );
    router.define(
      'landingPage',
      handler: _landingHandler,
    );
  }
}
