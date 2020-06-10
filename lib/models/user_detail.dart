import 'dart:core';

class UserDetail {

 var _fname;
 var _lname;
 var _email;
 List<dynamic> _cart;

 UserDetail(){
   this._fname ="";
   this._lname ="";
   this._email ="";
   this._cart = [];
 }
 
  
  String get getFname => _fname;
  String get getLname => _lname;
  String get getEmail => _email;
  List<dynamic> get getCart => _cart;

  set setFname(String value) {
    _fname = value;
  }
  set setLname(String value) {
    _lname = value;
  }
  set setEmail(String value) {
    _email = value;
  }
  set setCart(List<dynamic> value) {
    _cart = value;
  }

}