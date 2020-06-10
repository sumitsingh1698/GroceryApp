import 'dart:async';

import 'package:GroceryApp/authenticate/authentication_event.dart';
import 'package:GroceryApp/authenticate/authentication_state.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/home_page/homepage.dart';
import 'package:GroceryApp/login/login_page.dart';
import 'package:GroceryApp/splash/internet_not_connect_page.dart';
import 'package:GroceryApp/splash/splash_page.dart';
import 'package:GroceryApp/userdetail/set_user_detail.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authenticate/authentication_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition.toString());
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  UserRepository userRepository = UserRepository();
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
            return HomePage(
              userRepository,
            );
          } else if (state is SetUserDetailState) {
            return UserDetails(
              userRepository: userRepository,
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

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
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
