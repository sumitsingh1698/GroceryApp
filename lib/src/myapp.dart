import 'package:GroceryApp/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:GroceryApp/src/bloc/authentication_bloc/authentication_state.dart';
import 'package:GroceryApp/src/repository/auth_repository/user_repository.dart';
import 'package:GroceryApp/src/screens/landingpage.dart';
import 'package:GroceryApp/src/screens/loginpage.dart';
import 'package:GroceryApp/src/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            Future.delayed(const Duration(seconds: 4));
            return LoginPageParent(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return LandingPage();
          }
          if (state is AuthenticationFailed) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Error :${state.message}'),
                    ],
                  ),
                ),
              );
          }
          return SplashScreen();
        },
      ),
    );
  }
}
