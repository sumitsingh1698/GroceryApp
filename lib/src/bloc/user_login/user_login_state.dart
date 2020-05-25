import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class UserLoginState extends Equatable{}

class UserLoginInitState extends UserLoginState{
  @override
  List<Object> get props => null;

}

class UserLoginLoadingState extends UserLoginState{
  @override
  List<Object> get props => null;

}

class UserPhoneUnverifedSuccessState extends UserLoginState{

  @override
  List<Object> get props => throw UnimplementedError();

}

class UserPhoneVerifedSuccessState extends UserLoginState{

  @override
  List<Object> get props => throw UnimplementedError();

}


class UserLoginSuccessState extends UserLoginState{
  
  @override
  List<Object> get props => throw UnimplementedError();

}

class UserLoginFailedState extends UserLoginState{
   String message ;

  UserLoginFailedState({@required this.message});
  @override
  List<Object> get props => null;

}

