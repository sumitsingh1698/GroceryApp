import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserDetailEvent extends Equatable {}

@immutable
class PersonalDetailUpdateEvent extends UserDetailEvent{
  String email;
  String fname;
  String lname;

  PersonalDetailUpdateEvent({this.email,this.fname,this.lname});

  @override
  List<Object> get props => [email,fname,lname];  
}

@immutable
class AddressDetailUpdateEvent extends UserDetailEvent{
  String hno;
  String floor;
  String address;
  String landmark;
  String pincode;
  AddressDetailUpdateEvent({this.hno,this.floor,this.address,this.landmark,this.pincode});

  @override
  List<Object> get props => [hno,floor,address,landmark,pincode];  
}
