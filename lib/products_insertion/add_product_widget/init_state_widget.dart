import 'package:GroceryApp/products_insertion/bloc/bloc.dart';
import 'package:GroceryApp/products_insertion/bloc/mang_product_bloc.dart';
import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:GroceryApp/utils/EditTextUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitStateWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _opriceTextController = TextEditingController();
  final _discountTextController = TextEditingController();

  final _pktTextController = TextEditingController();
  final _quantityTextController = TextEditingController();
  final _qgivenTextController = TextEditingController();
  final _scatTextController = TextEditingController();
  final _catTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               
                EditTextUtils().getCustomEditTextArea(
                    labelValue: "scat :",
                    hintValue: "..",
                    controller: _scatTextController,
                    keyboardType: TextInputType.text,
                    icon: Icons.pin_drop,
                    color: Theme.of(context).primaryColor,
                    validator: (value) {
                      if (value.length == 0) {
                        return "can't be null";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 10,
                ),
                EditTextUtils().getCustomEditTextArea(
                    labelValue: "cat :",
                    hintValue: "..",
                    controller: _catTextController,
                    keyboardType: TextInputType.text,
                    icon: Icons.pin_drop,
                    color: Theme.of(context).primaryColor,
                    validator: (value) {
                      if (value.length == 0) {
                        return "can't be null";
                      }
                      return null;
                    }),
                     SizedBox(
                  height: 10,
                ),
                EditTextUtils().getCustomEditTextArea(
                    labelValue: "Product Name :",
                    hintValue: "rice",
                    controller: _nameTextController,
                    keyboardType: TextInputType.text,
                    icon: Icons.home,
                    color: Theme.of(context).primaryColor,
                    validator: (value) {
                      if (value.length == 0) {
                        return "can't be null";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: EditTextUtils().getCustomEditTextArea(
                            labelValue: "oprice :",
                            hintValue: "32",
                            controller: _opriceTextController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            icon: Icons.home,
                            color: Theme.of(context).primaryColor,
                            validator: (value) {
                              if (value.length == 0) {
                                return "can't be null";
                              }
                              return null;
                            })),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: EditTextUtils().getCustomEditTextArea(
                            labelValue: "discount :",
                            hintValue: "percent",
                            controller: _discountTextController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            icon: Icons.home,
                            color: Theme.of(context).primaryColor,
                            validator: (value) {
                              if (value.length == 0) {
                                return "can't be null";
                              }
                              if (value.length > 3) {
                                return "can't be greather than three";
                              }
                              return null;
                            }))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                EditTextUtils().getCustomEditTextArea(
                    labelValue: "pkt :",
                    hintValue: "..",
                    controller: _pktTextController,
                    keyboardType: TextInputType.number,
                    icon: Icons.add_location,
                    color: Theme.of(context).primaryColor,
                    validator: (value) {
                      if (value.length == 0) {
                        return "can't be null";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                EditTextUtils().getCustomEditTextArea(
                    labelValue: "total quantity in Stock :",
                    hintValue: "..",
                    controller: _quantityTextController,
                    keyboardType: TextInputType.number,
                    icon: Icons.location_on,
                    color: Theme.of(context).primaryColor,
                    validator: (value) {
                      if (value.length == 0) {
                        return "can't be null";
                      }

                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                EditTextUtils().getCustomEditTextArea(
                    labelValue: "Quantiy given to Consumer :",
                    hintValue: "..",
                    controller: _qgivenTextController,
                    keyboardType: TextInputType.text,
                    icon: Icons.pin_drop,
                    color: Theme.of(context).primaryColor,
                    validator: (value) {
                      if (value.length == 0) {
                        return "can't be null";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    print("name is ${_nameTextController.text.trim()}");

                    if (_formKey.currentState.validate()) {
                      BlocProvider.of<MangProductBloc>(context).add(
                          AddProductEvent(
                              product: Product(
                                  name: _nameTextController.text.trim(),
                                  oprice: _opriceTextController.text.trim(),
                                  discount: _discountTextController.text.trim(),
                                  pkt: _pktTextController.text.trim(),
                                  quantity: _quantityTextController.text.trim(),
                                  qgiven: _qgivenTextController.text.trim(),
                                  scat: _scatTextController.text.trim(),
                                  cat: _catTextController.text.trim())));
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
}
