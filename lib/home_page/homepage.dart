import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/home_page/homepage_widgets/homepage_drawer.dart';
import 'package:GroceryApp/home_page/homepage_widgets/homepage_first_section.dart';
import 'package:GroceryApp/home_page/homepage_widgets/homepage_silverappbar.dart';
import 'package:GroceryApp/home_page/homepage_widgets/homepage_third_section.dart';
import 'package:GroceryApp/home_page/homepage_widgets/hompage_second_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class HomePage extends StatefulWidget {
  UserRepository _userRepository;
  HomePage(this._userRepository);

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> items = ['Balbhadra', 'Maulik', 'Roshi'];
  String name = 'My Wishlist';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomePage_Drawer(widget._userRepository),

      body: CustomScrollView(
        slivers: <Widget>[
          HomePageSilverAppBar(),
          //   SliverFixedExtentList(
          //     itemExtent: 60.0,
          //     delegate: SliverChildListDelegate(
          //       [
          //         HomePageFirstSection(),
          //       ],
          //     ),
          //   ),
          //  SliverToBoxAdapter(
          //    child: HomePageSecondSection(),
          //  ),
          SliverFixedExtentList(
            itemExtent: 40.0,
            delegate: SliverChildListDelegate(
              [
                Container(
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
              ],
            ),
          ),
          HomePageThirdSection(),
        ],
      ),

      // body: SingleChildScrollView(
      //   child: Column(children: <Widget>[
      //     //first Section
      //     HomePageFirstSection(),

      //     // Second Section of Page (Picture V iew)
      //     HomePageSecondSection(),

      //     Container(
      //         margin: EdgeInsets.only(top: 10, bottom: 8),
      //         padding: EdgeInsets.only(left: 20),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: <Widget>[
      //             Text("Categories",
      //                 style: TextStyle(
      //                   fontSize: 25,
      //                   color: Colors.black,
      //                 ),
      //                 textAlign: TextAlign.left),
      //           ],
      //         )),

      //    //third Section
      //    HomePageThirdSection(),

      //   ]),
      // ),
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
