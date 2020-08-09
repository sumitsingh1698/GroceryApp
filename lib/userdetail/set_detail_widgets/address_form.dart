import 'package:GroceryApp/userdetail/bloc/user_detail_bloc.dart';
import 'package:GroceryApp/userdetail/bloc/user_detail_event.dart';
import 'package:GroceryApp/utils/EditTextUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressFrom extends StatelessWidget {
  final String hno;
  final String floor;
  final String streetNo;
  final String address;
  final String pincode;
  final String landmark;
  AddressFrom(
      {@required this.streetNo,
      @required this.floor,
      @required this.hno,
      @required this.pincode,
      @required this.address,
      @required this.landmark});

  final _formKey = GlobalKey<FormState>();
  final _hnoTextController = TextEditingController();
  final _floorTextController = TextEditingController();
  final _streetNoTextController = TextEditingController();

  final _addressTextController = TextEditingController();
  final _landmarkTextController = TextEditingController();
  final _pincodeTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _hnoTextController.text = hno;
    _floorTextController.text = floor;
    _streetNoTextController.text = streetNo;

    _addressTextController.text = address;
    _landmarkTextController.text = landmark;
    _pincodeTextController.text = pincode;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            EditTextUtils().getCustomEditTextArea(
                labelValue: "House No/Flat No :",
                hintValue: "123",
                controller: _hnoTextController,
                keyboardType: TextInputType.text,
                icon: Icons.home,
                color: Theme.of(context).primaryColor,
                validator: (value) {
                  return validateValues(value);
                }),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: EditTextUtils().getCustomEditTextArea(
                        labelValue: "Floor :",
                        hintValue: "02",
                        controller: _streetNoTextController,
                        keyboardType: TextInputType.text,
                        icon: Icons.home,
                        color: Theme.of(context).primaryColor,
                        validator: (value) {
                          return validateValues(value);
                        })),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: EditTextUtils().getCustomEditTextArea(
                        labelValue: "Street No :",
                        hintValue: "04",
                        controller: _floorTextController,
                        keyboardType: TextInputType.text,
                        icon: Icons.home,
                        color: Theme.of(context).primaryColor,
                        validator: (value) {
                          return validateValues(value);
                        }))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            EditTextUtils().getCustomEditTextArea(
                labelValue: "Enter Address :",
                hintValue: "..",
                controller: _addressTextController,
                keyboardType: TextInputType.text,
                icon: Icons.add_location,
                color: Theme.of(context).primaryColor,
                validator: (value) {
                  return validateAddressLandmark(value);
                }),
            SizedBox(
              height: 20,
            ),
            EditTextUtils().getCustomEditTextArea(
                labelValue: "Enter Landmark :",
                hintValue: "..",
                controller: _landmarkTextController,
                keyboardType: TextInputType.text,
                icon: Icons.location_on,
                color: Theme.of(context).primaryColor,
                validator: (value) {
                  return validateAddressLandmark(value);
                }),
            SizedBox(
              height: 20,
            ),
            EditTextUtils().getCustomEditTextArea(
                labelValue: "Enter Pincode :",
                hintValue: "110041",
                controller: _pincodeTextController,
                keyboardType: TextInputType.number,
                icon: Icons.pin_drop,
                color: Theme.of(context).primaryColor,
                validator: (value) {
                  if (value.length != 6) {
                    return "6 digit is only valid";
                  }
                  return null;
                }),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Theme.of(context).primaryColorDark,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  BlocProvider.of<UserDetailBloc>(context).add(
                      AddressDetailUpdateEvent(
                          hno: _hnoTextController.value.text.trim(),
                          floor: _floorTextController.value.text.trim(),
                          streetNo: _streetNoTextController.value.text.trim(),
                          address: _addressTextController.value.text.trim(),
                          landmark: _landmarkTextController.value.text.trim(),
                          pincode: _pincodeTextController.value.text.trim()));
                }
              },
              child: Text(
                "Submit Details",
                style: TextStyle(color: Colors.white),
              ),
            )
          ]),
        ),
      ),
    );
  }

  String validateValues(String value) {
    if (value.length < 1) {
      return "can't be Less than 2 Character";
    } else if (value.length > 30) {
      return "Can't be Greater than 30 Character";
    } else
      return null;
  }

  String validateAddressLandmark(String value) {
    if (value.length < 1) {
      return "can't be Empty";
    }
    if (value.length > 150) {
      return "Can't be Greater than 150 Character";
    } else
      return null;
  }
}
