import 'dart:async';

import 'package:GroceryApp/authenticate/authentication_event.dart';
import 'package:GroceryApp/authenticate/authentication_state.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/home_page/homepage.dart';
import 'package:GroceryApp/login/login_page.dart';
import 'package:GroceryApp/splash/internet_not_connect_page.dart';
import 'package:GroceryApp/splash/splash_page.dart';
import 'package:GroceryApp/userdetail/set_user_detail.dart';
import 'package:GroceryApp/utils/customPrimarySach.dart';
import 'package:GroceryApp/utils/custom_bloc_delegate.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authenticate/authentication_bloc.dart';

/* 
    Project Started Here : 

        

*/

void main() {
  //
  WidgetsFlutterBinding.ensureInitialized();

  // BlocSupervisor.delegate is execute when Bloc state is change :
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // UserRepository store the all function and Varriable stored for global
  UserRepository userRepository = UserRepository();

  //runApp function -> blocprovider created a Bloc
  // here , It create a AuthenticationBloc and Exccuted the Event Right here
  runApp(BlocProvider(
    create: (context) => AuthenticationBloc(userRepository)..add(AppStarted()),
    child: MyApp(userRepository: userRepository),
  ));
}

class MyApp extends StatefulWidget {
  final UserRepository _userRepository;

  MyApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserRepository get userRepository => widget._userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        fontFamily: 'OpenSans',
        primaryIconTheme: IconThemeData(color: Colors.white),
        primarySwatch: createMaterialColor(Color(0xFF00bef2)),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashPage();
          } else if (state is Unauthenticated) {
            return LoginPage(
              userRepository: userRepository,
            );
          } else if (state is Authenticated) {
            return HomepageParent(
              userRepository,
            );
          } else if (state is SetUserDetailState) {
            return UserDetails(
              userRepository: userRepository,
              page: "login",
            );
          } else if (state is InternetNotConnect) {
            return InternetNotConnectPage();
          } else {
            return SplashPage();
          }
        },
      ),
    );
  }
}

class InternetNotConnectPage extends StatefulWidget {
  @override
  _InternetNotConnectState createState() => _InternetNotConnectState();
}

class _InternetNotConnectState extends State<InternetNotConnectPage> {
  StreamSubscription<ConnectivityResult> subscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NoInternet(
          fontsize: 30,
          onclick: () {
            BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }
}
