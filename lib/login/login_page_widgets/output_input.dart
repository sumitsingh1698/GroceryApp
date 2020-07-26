import 'dart:async';

import 'package:GroceryApp/login/bloc/bloc.dart';
import 'package:GroceryApp/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class OtpInput extends StatefulWidget {
  @override
  _OtpInputState createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {

  int _counter = 30;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    counter();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 25, bottom: 10.0, left: 16.0, right: 16.0),
      child: Column(
        children: <Widget>[
          PinEntryTextField(
              fields: 6,
              onSubmit: (String pin) {
                BlocProvider.of<LoginBloc>(context)
                    .add(VerifyOtpEvent(otp: pin));
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[

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
              ),
              Padding(
              
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: _counter != 0 ? null : () {
                    BlocProvider.of<LoginBloc>(context).add(SendOtpEvent());
                  },
                  color: _counter == 0 ?Theme.of(context).primaryColorDark:Colors.grey ,
                  child: Text(
                    _counter==0 ? "Resend":"Wait($_counter)s for Resend",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  void counter(){
     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState((){
           if(_counter > 0){
             _counter = _counter - 1;
           }else{
             _timer.cancel();
           }
        });
      });
  }
  }
  

