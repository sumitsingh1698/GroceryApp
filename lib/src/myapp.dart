

import 'package:GroceryApp/src/models/custommaterialcolor.dart';
import 'package:GroceryApp/src/screens/loadingpage.dart';
import 'package:GroceryApp/src/services/authservice.dart';
import 'package:GroceryApp/src/services/internetconnectivity.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    bool isOffline = false;
  @override
  initState(){
        super.initState();
        ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
     connectionStatus.connectionChange.listen(connectionChanged);
  }
  
    void connectionChanged(dynamic hasConnection) {
      print("inconnectionchanged");
    setState(() {
  
      isOffline = !hasConnection;
      print(isOffline);

    });
  }

  @override
  Widget build(BuildContext context) {
    
     

    return MaterialApp(
      title: 'Firebase Phone Auth Demo',
      theme: ThemeData( 
        
       primarySwatch: CustomMaterialColor().createMaterialColor(Color(0xFFD97ED0)),
      ),
      home: isOffline ? LoadingPage() :  AuthService().handleAuth(),
    );
  }
}