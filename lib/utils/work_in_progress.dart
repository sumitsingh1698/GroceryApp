import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WorkInProgressPage extends StatelessWidget {
  const WorkInProgressPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.wrench,
                    size: 40,
                  ),
                ),
              )),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.smileBeam,size: 50,),
                   Text(
                          "Work in Progress",
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          "Sorry for Inconvenience",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 30,),
                        RaisedButton(onPressed: (){
                           Navigator.pop(context);
                        },child: Text("Back"),color: Theme.of(context).accentColor,)
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}
