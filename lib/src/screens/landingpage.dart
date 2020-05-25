import 'package:GroceryApp/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:GroceryApp/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          child: RaisedButton(
              onPressed: () {
                setState(() {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                });
              },
              child: Text("SignOut"))),
    );
  }
}
