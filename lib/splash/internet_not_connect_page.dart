import 'package:GroceryApp/authenticate/authentication_bloc.dart';
import 'package:GroceryApp/authenticate/authentication_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetNotConnectPage extends StatefulWidget {
  @override
  _InternetNotConnectPageState createState() => _InternetNotConnectPageState();
}

class _InternetNotConnectPageState extends State<InternetNotConnectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.signal_wifi_off,size: 70,color: Colors.red,),
            SizedBox(height: 20.0,),
            Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              color: Colors.lightGreen,
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
              },
              child: Text("Try Again",style: TextStyle(color :Colors.white),),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
