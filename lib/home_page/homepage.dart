import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/home_page/homepage_widgets/homepage_drawer.dart';
import 'package:GroceryApp/home_page/homepage_widgets/homepage_first_section.dart';
import 'package:GroceryApp/home_page/homepage_widgets/homepage_third_section.dart';
import 'package:GroceryApp/home_page/homepage_widgets/hompage_second_section.dart';
import 'package:flutter/material.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class HomePage extends StatefulWidget {
  UserRepository _userRepository;
  HomePage(this._userRepository);

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List list = ['12', '11'];

  final List<String> items = ['Balbhadra', 'Maulik', 'Roshi'];
  static const double height = 366.0;
  String name = 'My Wishlist';
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.black54);
    final TextStyle descriptionStyle = theme.textTheme.subhead;
    ShapeBorder shapeBorder;

    return Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          "Grocery Store",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () async {
              // final int selected = await showSearch<int>(
              //   context: context,
              //   //delegate: _delegate,
              // );
            },
          ),
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
              height: 150.0,
              width: 30.0,
              child: new GestureDetector(
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
            ),
          )
        ],
      ),
      drawer: HomePage_Drawer(widget._userRepository),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          //first Section
          HomePageFirstSection(),

          // Second Section of Page (Picture V iew)
          HomePageSecondSection(),

         
          Container(
              margin: EdgeInsets.only(top: 10, bottom: 8),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Categories",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left),
                ],
              )),
        
         //third Section 
         HomePageThirdSection(),

        ]),
      ),
    );
  }

  Icon keyloch = new Icon(
    Icons.arrow_forward,
    color: Colors.black26,
  );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 5.0, right: 0.0, top: 5.0, bottom: 0.0),
      );
}
