import 'dart:async';

import 'package:GroceryApp/authenticate/authentication_bloc.dart';
import 'package:GroceryApp/authenticate/bloc.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/login/bloc/login_bloc.dart';
import 'package:GroceryApp/login/bloc/login_event.dart';
import 'package:GroceryApp/login/bloc/login_state.dart';
import 'package:GroceryApp/login/login_page_widgets/header.dart';
import 'package:GroceryApp/login/login_page_widgets/loading_indicator.dart';
import 'package:GroceryApp/splash/internet_not_connect_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_page_widgets/number_input.dart';
import 'login_page_widgets/output_input.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(userRepository: userRepository),
      child: Scaffold(
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc _loginBloc;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      BlocProvider.of<LoginBloc>(context).add(CheckInternet());
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: (context, loginState) {
        if (loginState is ExceptionState || loginState is OtpExceptionState) {
          String message;
          if (loginState is ExceptionState) {
            message = "Error Occured Try Again!!  ";
          } else if (loginState is OtpExceptionState) {
            message = "OTP Error Occured Try Again!!  ";
          }
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [Text(message), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Header(),
                        SingleChildScrollView(
                          child: Container(
                            child: getViewAsPerState(state),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  getViewAsPerState(LoginState state) {
    if (state is Unauthenticated) {
      return NumberInput();
    } else if (state is OtpSentState || state is OtpExceptionState) {
      return OtpInput();
    } else if (state is LoadingState) {
      return LoadingIndicator();
    } else if (state is LoginCompleteState) {
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
    } else if (state is InternetNotConnectState) {
      return NoInternet(
        onclick: () {
          BlocProvider.of<LoginBloc>(context).add(CheckInternet());
        },
        fontsize: 20,
      );
    } else {
      return NumberInput();
    }
  }
}
