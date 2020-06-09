import 'package:flutter/material.dart';

class EditTextUtils {
  TextFormField getCustomEditTextArea(
      {String labelValue = "",
      String hintValue = "",
      Function validator,
      IconData icon,
      bool validation,
      TextEditingController controller,
      TextInputType keyboardType = TextInputType.text,
      String validationErrorMsg,
      Color color,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          prefixStyle: TextStyle(color: color),
          fillColor: Colors.white.withOpacity(0.6),
          filled: true,
          isDense: true,
          labelStyle: TextStyle(color: color),
          focusColor: color,
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
            borderSide: new BorderSide(
              color: color,
              width: 1.0,
            ),
          ),
          disabledBorder: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
            borderSide: new BorderSide(
              color: color,
              width: 1.0,
            ),
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
            borderSide: new BorderSide(
              color: color,
              width: 1.0,
            ),
          ),
          hintText: hintValue,
          labelText: labelValue,),
    validator: validator,
    );
  }
}
