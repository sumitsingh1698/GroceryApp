import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 100.0,
                width: 100.0,
                  child: CircularProgressIndicator(
          ),
        ),
      ],
    );
  }
}