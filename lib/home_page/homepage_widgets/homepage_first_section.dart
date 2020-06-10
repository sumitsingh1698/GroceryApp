import 'package:flutter/material.dart';

class HomePageFirstSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        padding: EdgeInsets.only(left: 20, top: 10, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Featured",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left),
            Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.black,
            )
          ],
        ));
  }
}
