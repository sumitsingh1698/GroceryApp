import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class UserLoginEvent extends Equatable{}


class SubmitPhoneNumberEvent extends UserLoginEvent{
 
  final String phoneNo;
 
   SubmitPhoneNumberEvent({@required this.phoneNo});

  @override
  List<Object> get props => null;

}

class SubmitOtpEvent extends UserLoginEvent{ 
    
   final String otp;
   SubmitOtpEvent({@required this.otp});


  @override
  List<Object> get props => null;
}

