import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/home_page/homepage.dart';
import 'package:GroceryApp/login/login_page.dart';
import 'package:GroceryApp/splash/splash_page.dart';
import 'package:GroceryApp/userdetail/set_user_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const String LOGIN_PAGE = "/login";
const String SPLASH_PAGE = "/";
const String HOME_PAGE = "/home";
const String USER_DETAIL = "/user_detail";

class Router {
  static final userRepository =
      UserRepository(firebaseAuth: FirebaseAuth.instance);

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                LoginPage(userRepository: userRepository));
      case HOME_PAGE:
        return MaterialPageRoute(builder: (_) => HomePage(userRepository));
      case SPLASH_PAGE:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case SPLASH_PAGE:
        return MaterialPageRoute(builder: (_) => UserDetails(userRepository: userRepository,));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
