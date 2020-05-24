import 'package:GroceryApp/src/services/authservice.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Landing Page")),
      body: Container(
        child: RaisedButton(onPressed: (){
          AuthService().signout();
        },child:Text("SignOut"))
      ),
    );
  }
}
