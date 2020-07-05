import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageSilverAppBar extends StatelessWidget {
  final List list = ['12', '11'];

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      actions: <Widget>[
        new GestureDetector(
      
          child: Stack(
            children: <Widget>[
              new IconButton(
                  icon: new Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart_screen()));
                  }),
              list.length == 0
                  ? new Container()
                  : new Positioned(
                      child: new Stack(
                      children: <Widget>[
                        new Icon(Icons.brightness_1,
                            size: 20.0, color: Colors.orange.shade500),
                        new Positioned(
                            top: 4.0,
                            right: 5.5,
                            child: new Center(
                              child: new Text(
                                list.length.toString(),
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    )),
            ],
          ),
        ),
      ],
      title: Container(
        height: 36.0,
        width: double.infinity,
        child: CupertinoTextField(
          keyboardType: TextInputType.text,
          placeholder: 'Search any product',
          placeholderStyle: TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 14.0,
          ),
          prefix: Padding(
            padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
            child: Icon(
              Icons.search,
              color: Color(0xffC4C6CC),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color(0xffF0F1F5),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).accentColor,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: <Widget>[
            SizedBox(height: 90.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
              child: Center(child: Text("Grocery App")),
            ),
          ],
        ),
      ),
    );
  }
}
