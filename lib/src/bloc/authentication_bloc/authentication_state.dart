import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
abstract class AuthenticationState extends Equatable {

  const AuthenticationState();
  @override
  List<Object> get props => [];
}


class Uninitialized extends AuthenticationState {}

class AuthenticatedLoading extends AuthenticationState{

}

class Authenticated extends AuthenticationState {
  FirebaseUser user;
  Authenticated({@required this.user}); 
}

class Unauthenticated extends AuthenticationState {}
 
class AuthenticationFailed extends AuthenticationState{
  String message;
  AuthenticationFailed({@required this.message});
}