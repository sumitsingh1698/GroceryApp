import 'package:GroceryApp/authenticate/authentication_bloc.dart';
import 'package:GroceryApp/authenticate/bloc.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/login/bloc/login_bloc.dart';
import 'package:GroceryApp/login/bloc/login_event.dart';
import 'package:GroceryApp/login/bloc/login_state.dart';
import 'package:GroceryApp/utils/EditTextUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
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
                        Container(
                          child: getViewAsPerState(state),
                          decoration: BoxDecoration(
                              color: Colors.white,
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
       
      BlocProvider.of<AuthenticationBloc>(context)
          .add(LoggedIn());

    } else {
      return NumberInput();
    }
  }
}

class Header extends StatelessWidget {
  
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Welcome To Grocery App",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: CircularProgressIndicator(),
        ),
      );
}

class NumberInput extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 25, bottom: 10.0, left: 16.0, right: 16.0),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: EditTextUtils().getCustomEditTextArea(
                labelValue: "Enter phone number",
                hintValue: "9876543210",
                controller: _phoneTextController,
                keyboardType: TextInputType.number,
                icon: Icons.phone,
                color: Theme.of(context).primaryColor,
                validator: (value) {
                  return validateMobile(value);
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: RaisedButton(
              color: Theme.of(context).primaryColorDark,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  BlocProvider.of<LoginBloc>(context).add(SendOtpEvent(
                      phoNo: "+91" + _phoneTextController.value.text));
                }
              },
              child: Text(
                "Submit",   
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }
}

class OtpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(
          top: 25, bottom: 10.0, left: 16.0, right: 16.0),
      child: Column(
        children: <Widget>[
          PinEntryTextField(
              fields: 6,
              onSubmit: (String pin) {
                BlocProvider.of<LoginBloc>(context)
                    .add(VerifyOtpEvent(otp: pin));
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(AppStartEvent());
              },
              color: Theme.of(context).primaryColorDark,
              child: Text(
                "Back",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
