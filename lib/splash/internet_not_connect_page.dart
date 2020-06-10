import 'package:flutter/material.dart';


class NoInternet extends StatelessWidget {
  final Function onclick;
  final double fontsize;
  NoInternet({@required this.onclick,@required this.fontsize});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.signal_wifi_off,size: (fontsize*2),color: Theme.of(context).primaryColor,),
            SizedBox(height: fontsize/2,),
            Text(
              "No Internet Connection",
              style: TextStyle(fontSize: fontsize, color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: fontsize/2,
            ),
            
                RaisedButton(
              color: Theme.of(context).primaryColorDark,
              onPressed: onclick,
              child: Text("Try Again",style: TextStyle(color :Colors.white),),
            )
          ],
        ),
      );
   
  }
}
