
import 'package:GroceryApp/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:GroceryApp/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:GroceryApp/src/myapp.dart';
import 'package:GroceryApp/src/repository/auth_repository/user_repository.dart';
import 'package:GroceryApp/src/simple_bloc_Delgate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AppStarted()),
      child: MyApp(userRepository: userRepository),
    ),
  );
}
