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
    if (event is AppStarted) {
      yield Loading();
      if (await userRepository.checkConnectivity()) {
        print("check connectivtiy");
        final bool hasToken = await userRepository.getUser() != null;

        if (hasToken) {
          await userRepository.getDetails();
          print('here login detail');
          if (userRepository.userDetail.getEmail == "") {
            yield SetUserDetailState();
          } else {
            yield Authenticated();
          }
        } else {
          yield Unauthenticated();
        
         }
         } 
         else {
        print("no Internet is triggered");
        yield InternetNotConnect();
      }
    }

    if (event is LoggedIn) {
      yield Loading();
      await userRepository.getDetails();
      print('here for detail');
      if (userRepository.userDetail.getEmail == "") {
        yield SetUserDetailState();
      } else {
        yield Authenticated();
      }
    }

    if (event is LoggedOut) {
      yield Loading();
      await userRepository.signOut();
      yield Unauthenticated();
    }
  }
}
