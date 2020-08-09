import 'package:GroceryApp/userdetail/bloc/user_detail_bloc.dart';
import 'package:GroceryApp/userdetail/bloc/user_detail_event.dart';
import 'package:GroceryApp/utils/EditTextUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsInputs extends StatelessWidget {
  final String email;
  final String fname;
  final String lname;
  DetailsInputs(
      {@required this.email, @required this.fname, @required this.lname});

  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _fnameTextController = TextEditingController();
  final _lnameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _emailTextController.text = email;
    _fnameTextController.text = fname;
    _lnameTextController.text = lname;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                EditTextUtils().getCustomEditTextArea(
                    labelValue: "Enter First Name",
                    hintValue: "jhon",
                    controller: _fnameTextController,
                    keyboardType: TextInputType.text,
                    icon: Icons.title,
                    color: Theme.of(context).primaryColor,
                    validator: (value) {
                      return validateNames(value);
                    }),
                SizedBox(
                  height: 20,
                ),
                EditTextUtils().getCustomEditTextArea(
                    labelValue: "Enter Last Name",
                    hintValue: "singh",
                    controller: _lnameTextController,
                    keyboardType: TextInputType.text,
                    icon: Icons.person,
                    color: Theme.of(context).primaryColor,
                    validator: (value) {
                      return validateNames(value);
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
                    color: Theme.of(context).primaryColor,
                    validator: (value) {
                      return validateEmail(value);
                    }),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      print("confirmed form");
                      BlocProvider.of<UserDetailBloc>(context).add(
                          PersonalDetailUpdateEvent(
                              email: _emailTextController.value.text,
                              fname: _fnameTextController.value.text,
                              lname: _lnameTextController.value.text));
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ]),
        ),
      ),
    );
  }

//Names Validatation
  String validateNames(String value) {
    if (value.length < 1) {
      return "Can't be Less than 2 Character";
    } else if (value.length > 30)
      return "Can't length Greater than 30";
    else if (!RegExp(r"^[a-zA-Z0-9\s]+$").hasMatch(value)) {
      return "Can't be Special Character";
    } else
      return null;
  }

  //Email Validation
  String validateEmail(String value) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Not Valid Email";
    } else
      return null;
  }
}
