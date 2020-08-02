import 'dart:async';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc(this.userRepository);

  @override
  AuthenticationState get initialState => Loading();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // Appstart event triggered than Execute this :
    if (event is AppStarted) {
      yield Loading();

      // First check the Conectivity :
      if (await userRepository.checkConnectivity()) {
        //If connected to Internet

        // print("check connectivtiy");

        // Check user is loggedIn or not :
        final bool hasToken = await userRepository.getUser() != null;

        // If login :
        if (hasToken) {
          // Get detail of User from Database :
          await userRepository.getDetails();
          print('here login detail');

          // Checked They have personal detail :
          if (userRepository.userDetail.getEmail == "") {
            // If Not Go to SetUserDetailState :
            yield SetUserDetailState();
          } else {
            // Authenticated State if User Already saved
            // his/her personal detail :
            yield Authenticated();
          }
        } else {
          //Unauthenticated State If Not LoggIN
          // Go to Login Page :
          yield Unauthenticated();
        }
      } else {
        // If There is not Interent
        // It will trigger this :
        print("no Internet is triggered");
        yield InternetNotConnect();
      }
    }
    // LoggedIn Event trigger :
    else if (event is LoggedIn) {
      yield Loading();
      await userRepository.getDetails();
      print('here for detail');
      if (userRepository.userDetail.getEmail == "") {
        yield SetUserDetailState();
      } else {
        yield Authenticated();
      }
    }
    //Logout Event :
    if (event is LoggedOut) {
      yield Loading();
      await userRepository.signOut();
      yield Unauthenticated();
    }
  }
}
