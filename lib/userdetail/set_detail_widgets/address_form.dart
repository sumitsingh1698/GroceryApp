import 'package:GroceryApp/userdetail/bloc/user_detail_bloc.dart';
import 'package:GroceryApp/userdetail/bloc/user_detail_event.dart';
import 'package:GroceryApp/utils/EditTextUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressFrom extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _hnoTextController = TextEditingController();
  final _floorTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _landmarkTextController = TextEditingController();
  final _pincodeTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              EditTextUtils().getCustomEditTextArea(
                  labelValue: "House No/Flat No.",
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
              EditTextUtils().getCustomEditTextArea(
                  labelValue: "Floor :",
                  hintValue: "2",
                  controller: _floorTextController,
                  keyboardType: TextInputType.text,
                  icon: Icons.home,
                  color: Theme.of(context).primaryColor,
                  validator: (value) {
                   return validateValues(value);
                  }),
              SizedBox(
                height: 20,
              ),
              EditTextUtils().getCustomEditTextArea(
                  labelValue: "Enter Address",
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
                  labelValue: "Enter Landmark",
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
                  labelValue: "Enter Pincode",
                  hintValue: "110041",
                  controller: _pincodeTextController,
                  keyboardType: TextInputType.number,
                  icon: Icons.pin_drop,
                  color: Theme.of(context).primaryColor,
                  validator: (value) {
                   return validateAddressLandmark(value);
                  }),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColorDark,
                onPressed: () {
                if(_formKey.currentState.validate()){
                    BlocProvider.of<UserDetailBloc>(context).add(
                      AddressDetailUpdateEvent(
                          hno: _hnoTextController.value.text,
                          floor: _floorTextController.value.text,
                          address: _addressTextController.value.text,
                          landmark: _landmarkTextController.value.text));
                }
                },
                child: Text("Submit Details"),
              )
            ]),
      ),
    );
  }
  String validateValues(String value) {
     if(value.length < 1){
       return "can't be Less than 2 Character";
     }
     else if(value.length > 30) {
       return "Can't be Greater than 30 Character";
     }
    else
      return null;
  }
  String validateAddressLandmark(String value) {
     if(value.length < 1){
       return "can't be Empty";
     }
     if(value.length > 150) {
       return "Can't be Greater than 150 Character";
     }
    else
      return null;
  }
}