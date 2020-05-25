import 'package:GroceryApp/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:GroceryApp/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:GroceryApp/src/bloc/user_login/user_login_bloc.dart';
import 'package:GroceryApp/src/bloc/user_login/user_login_event.dart';
import 'package:GroceryApp/src/bloc/user_login/user_login_state.dart';
import 'package:GroceryApp/src/repository/auth_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageParent extends StatelessWidget {

  UserRepository userRepository;

  LoginPageParent({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserLoginBloc(userRepository: userRepository),
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget{
 UserLoginBloc _userLoginBloc; 
  @override
  Widget build(BuildContext context) {
    bool _verfied = true;
    TextEditingController _phoneNumberController = TextEditingController();
    TextEditingController _otpController = TextEditingController();

  _userLoginBloc =   BlocProvider.of<UserLoginBloc>(context);

    Widget unVerfiedPhone = Column(
      children: <Widget>[
        TextField(
          controller: _otpController,
          decoration: InputDecoration(
            hintText: 'OTP',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: BlocListener<UserLoginBloc, UserLoginState>(
            listener: (context, state) {
          if (state is UserPhoneUnverifedSuccessState) {
            // Center(child: unVerfiedPhone);
          } else if (state is UserLoginLoadingState) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Registering...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          } else if (state is UserLoginSuccessState) {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          }else if (state is UserLoginFailedState) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${state.message}'),
                    ],
                  ),
                ),
              );
          }
        }, child: BlocBuilder<UserLoginBloc, UserLoginState>(
                builder: (context, state) {
          return Container(
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ]),
                MaterialButton(
                    onPressed: () {
                      if (_verfied) {
                        print("inButton ");
                        print("${_phoneNumberController.text}");
                       _userLoginBloc.add(
                            SubmitPhoneNumberEvent(
                                phoneNo: _phoneNumberController.text));
                       
                      } else
                        _userLoginBloc
                            .add(SubmitOtpEvent(otp: _otpController.text));
                    },
                    color: Colors.blue,
                    child: Text("Login"))
              ],
            ),
          );
        })));
  }
}
