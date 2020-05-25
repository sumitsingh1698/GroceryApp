import 'package:GroceryApp/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:GroceryApp/src/bloc/authentication_bloc/authentication_state.dart';
import 'package:GroceryApp/src/repository/auth_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository});

  @override
  // TODO: implement initialState
  AuthenticationState get initialState => AuthenticatedLoading();
  
  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    try {
      if (event is AppStarted) {
        var isSignedIn = await userRepository.isSignedIn();
          
        if (isSignedIn) {
          LoggedIn();
        } else {
          yield Unauthenticated();
        }
      }if(event is LoggedIn){
          FirebaseUser user = await userRepository.getUser();
          yield Authenticated(user: user);
      }
      if(event is LoggedOut){
          await userRepository.signout();
          yield Unauthenticated();
      }
    } catch (e) {
      yield AuthenticationFailed(message: e.toString());
    }
  }
}
