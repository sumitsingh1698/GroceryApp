import 'dart:core';

class UserDetail {
  var _uid;
  var _fname;
  var _lname;
  var _email;
  var _phoneNo;
  var _floor;
  var _streetNo;
  var _hno;
  var _address;
  var _landmark;
  var _pincode;
  var _createdDate;
  List<dynamic> _cart;
  List<int> _cartItem;

  UserDetail() {
    this._fname = "";
    this._lname = "";
    this._email = "";
    this._cart = List();
    this._hno = "";
    this._floor = "";
    this._streetNo = "";
    this._address = "";
    this._landmark = "";
    this._pincode = "";
    this._createdDate = "";
    this._uid = "";
    this._cartItem = List();
    this._phoneNo = "";
  }

  // getters
  String get getUid => _uid;
  String get getFname => _fname;
  String get getLname => _lname;
  String get getEmail => _email;
  List<dynamic> get getCart => _cart;
  String get getHno => _hno;
  String get getFloor => _floor;
  String get getStreetNo => _streetNo;
  String get getAddress => _address;
  String get getLandmark => _landmark;
  String get getPincode => _pincode;
  String get getCreateDate => _createdDate;
  String get getPhoneNo => _phoneNo;
  List<dynamic> get getCartQuantity => _cartItem;

//Setter
  set setUid(String value) {
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
    _cart = List();
    for (int i = 0; i < value.length; i++) {
      _cart.add(value[i]);
      _cartItem.add(1);
    }
  }

  set setHno(String value) {
    _hno = value;
  }

  set setFloor(String value) {
    _floor = value;
  }

  set setStreetNo(String value) {
    _streetNo = value;
  }

  set setAddress(String value) {
    _address = value;
  }

  set setLandmark(String value) {
    _landmark = value;
  }

  set setPincode(String value) {
    _pincode = value;
  }

  set setCreateDate(String value) {
    _createdDate = value;
  }

  set setPhoneNo(String phoneNo) {
    this._phoneNo = phoneNo;
  }

  bool insertInCart(dynamic productId) {
    if (_cart.contains(productId)) {
      print("already in cart");
      return false;
    }
    _cart.add(productId);
    _cartItem.add(1);
    return true;
  }

  bool insertInCartQuantity(productId) {
    int ind = _cart.indexOf(productId);
    print("data ${_cartItem.elementAt(ind)}");
    _cartItem.replaceRange(ind, ind + 1, {_cartItem.elementAt(ind) + 1});
    return true;
  }

  bool removeInCartQuantity(productId) {
    int ind = _cart.indexOf(productId);
    print("data ${_cartItem.elementAt(ind)}");
    if (_cartItem.elementAt(ind) >= 1)
      _cartItem.replaceRange(ind, ind + 1, {_cartItem.elementAt(ind) - 1});
    return true;
  }

  bool deleteInCart(productId) {
    int ind = _cart.indexOf(productId);
    print("data ${_cartItem.elementAt(ind)}");

    _cart.removeAt(ind);
    _cartItem.removeAt(ind);
    return true;
  }
}
