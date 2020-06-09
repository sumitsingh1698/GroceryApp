import 'dart:core';

class UserDetail {
 var _uid;
 var _fname;
 var _lname;
 var _email;
 var _floor;
 var _hno;
 var _address;
 var _landmark;
 var _pincode;
 var _createdDate;
 List<dynamic> _cart;

 UserDetail(){
   this._fname ="";
   this._lname ="";
   this._email ="";
   this._cart = [];
   this._hno = "";
   this._floor = "";
   this._address = "";
   this._landmark = "";
   this._pincode = "";
   this._createdDate = "";
   this._uid = "";
 }
 
  // getters 
  String get getUid => _uid;
  String get getFname => _fname;
  String get getLname => _lname;
  String get getEmail => _email;
  List<dynamic> get getCart => _cart;
  String get getHno => _hno;
  String get getFloor => _floor;
  String get getAddress => _address;
  String get getLandmark => _landmark;
  String get getPincode => _pincode;
  String get getCreateDate => _createdDate;


//Setter 
  set setUid(String value){
    _uid = value;
  }
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

  set setHno(String value) {
    _hno = value;
  }
  set setFloor(String value) {
    _floor = value;
  }
  set setAddress(String value) {
    _address = value;
  }
  set setLandmark(String value) {
    _landmark = value;
  }
  set setPincode(String value){
    _pincode = value;
  }
  set setCreateDate(String value) {
    _createdDate = value;
  }


}