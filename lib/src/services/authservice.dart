import 'package:GroceryApp/src/screens/landingpage.dart';
import 'package:GroceryApp/src/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  //handle auth
  handleAuth(){
     return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return LandingPage();
          } else {
            return LoginPage();
          }
        });
  }
  
  // signout 
   Future<void> signout() async {
    
    try {
      // signout code
      await FirebaseAuth.instance.signOut();
    
    } catch (e) {
      print(e.toString());
    }
  }

  //signin 
  Future<void> signin(AuthCredential phoneAuthCredential) async {
     try {
      await FirebaseAuth.instance
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult authRes) {
        print(authRes.user);
      
      });
    
     print("SignedIn");
    
    } catch (e) {
      print(e.toString());
    }
  }

}