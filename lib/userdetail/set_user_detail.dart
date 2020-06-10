import 'package:GroceryApp/authenticate/authentication_bloc.dart';
import 'package:GroceryApp/authenticate/authentication_event.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/userdetail/bloc/user_bloc.dart';
import 'package:GroceryApp/userdetail/bloc/user_detail_bloc.dart';
import 'package:GroceryApp/utils/EditTextUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GroceryApp/login/login_page.dart';

class UserDetails extends StatelessWidget {
  final UserRepository userRepository;

  UserDetails({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserDetailBloc>(
      create: (context) => UserDetailBloc(userRepository: userRepository),
      child: Scaffold(
        body: UserDetailForm(),
      ),
    );
  }
}

class UserDetailForm extends StatefulWidget {
  @override
  _UserDetailFormState createState() => _UserDetailFormState();
}

class _UserDetailFormState extends State<UserDetailForm> {
  UserDetailBloc _userDetailBloc;
  @override
  void initState() {
    _userDetailBloc = BlocProvider.of<UserDetailBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDetailBloc, UserDetailState>(
      bloc: _userDetailBloc,
      listener: (context, userDetailState) {
        if (userDetailState is ExceptionState) {
          String message = userDetailState.message;

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
      child: BlocBuilder<UserDetailBloc, UserDetailState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: getViewAsPerState(state),
            ),
          );
        },
      ),
    );
  }

  getViewAsPerState(UserDetailState state) {
    if (state is InitialUserDetailState) {
      return DetailsInputs();
    } else if (state is LoadingState) {
      return LoadingIndicator();
    } else if (state is SuccessSubmitedState) {
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
    } else {
      // return NumberInput();
    }
  }
}

class DetailsInputs extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _fnameTextController = TextEditingController();
  final _lnameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Here"),
              EditTextUtils().getCustomEditTextArea(
                  labelValue: "Enter First Name",
                  hintValue: "jhon",
                  controller: _fnameTextController,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                  validator: (value) {
                    if (value.length != 10) {}
                  }),
              SizedBox(
                height: 20,
              ),
              EditTextUtils().getCustomEditTextArea(
                  labelValue: "Enter Last Name",
                  hintValue: "singh",
                  controller: _lnameTextController,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                  validator: (value) {
                    if (value.length != 10) {}
                  }),
              SizedBox(
                height: 20,
              ),
              EditTextUtils().getCustomEditTextArea(
                  labelValue: "Enter Email",
                  hintValue: "abcd124@gmail.com",
                  controller: _emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                  validator: (value) {
                    if (value.length != 10) {}
                  }),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {
                  BlocProvider.of<UserDetailBloc>(context).add(
                      PersonalDetailUpdateEvent(
                          email: _emailTextController.value.text,
                          fname: _fnameTextController.value.text,
                          lname: _lnameTextController.value.text));
                },
                child: Text("Submit Details"),
              )
            ]),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,),
        Text("Saving....")
      ],
    ));
  }
}
