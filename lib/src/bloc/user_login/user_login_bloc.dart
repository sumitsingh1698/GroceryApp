import 'package:GroceryApp/src/bloc/user_login/user_login_event.dart';
import 'package:GroceryApp/src/bloc/user_login/user_login_state.dart';
import 'package:GroceryApp/src/repository/auth_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  UserRepository _userRepository;

  UserLoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  UserLoginState get initialState => UserLoginLoadingState();

  @override
  Stream<UserLoginState> mapEventToState(UserLoginEvent event) async* {
    print("Enter in state");
    if (event is SubmitPhoneNumberEvent) {
      try {
        var status = await _userRepository.submitPhoneNumber(event.phoneNo);
        print(status);
      } catch (e) {
        print("error user ");
        yield UserLoginFailedState(message: e.message);
      }
    }
    if (event is SubmitOtpEvent) {
      try {
        await _userRepository.submitOTP(event.otp);
        yield UserLoginSuccessState();
      } catch (e) {
        yield UserLoginFailedState(message: e.message);
      }
    }
  }
}
