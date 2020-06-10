import 'package:GroceryApp/home_page/models/photo.dart';
import 'package:GroceryApp/utils/work_in_progress.dart';
import 'package:flutter/material.dart';

class HomePageThirdSection extends StatelessWidget {
  ShapeBorder shapeBorder;
  List<Photo> photos = <Photo>[
    Photo(
      assetName: 'assets/img/milk.jpg',
      title: 'Milk',
    ),
    Photo(
      assetName: 'assets/img/veg.jpg',
      title: 'Fresh vegetables',
    ),
    Photo(
      assetName: 'assets/img/dairyproduct.jpg',
      title: 'Dairy products',
    ),
    Photo(
      assetName: 'assets/img/dailyneed.jpg',
      title: 'Daily needs',
    ),
    Photo(
      assetName: 'assets/img/freshfruit.jpg',
      title: 'Fresh fruits',
    ),
    Photo(
      assetName: 'assets/img/biscuit.jpg',
      title: 'Bakery & Biscuits',
    ),
    Photo(
      assetName: 'assets/img/readytocook.jpg',
      title: 'Ready to cook',
    ),
    Photo(
      assetName: 'assets/img/beverages.jpg',
      title: 'Beverages',
    ),
    Photo(
      assetName: 'assets/img/rice.jpg',
      title: 'Rice & Rice Products',
    ),
    Photo(
      assetName: 'assets/img/snacks.jpg',
      title: 'Snacks & Sweets',
    ),
    Photo(
      assetName: 'assets/img/staples.jpg',
      title: 'Staples & Spices',
    ),
    Photo(
      assetName: 'assets/img/flour.jpg',
      title: 'Flours & Pulses',
    ),
    Photo(
      assetName: 'assets/img/sauce.jpg',
      title: 'Spreads & Sauces',
    ),
    Photo(
      assetName: 'assets/img/cereals.jpg',
      title: 'Breakfast cereals',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: 750,
      child: GridView.builder(
        itemCount: photos.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 3 : 5),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {
              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WorkInProgressPage()));
                                 },
              child: new Card(
                margin: EdgeInsets.all(10.0),
                shape: shapeBorder,
                elevation: 3.0,
                child: new Container(
                  //  mainAxisSize: MainAxisSize.max,
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: Image.asset(
                          photos[index].assetName,
                          fit: BoxFit.cover,
                        )),
                        Container(
                          color: Colors.black26,
                        ),
                        Container(
                          //margin: EdgeInsets.only(left: 10.0),
                          padding: EdgeInsets.only(left: 3.0, bottom: 3.0),
                          alignment: Alignment.bottomLeft,
                          child: new GestureDetector(
                            onTap: () {
                                  },
                            child: new Text(
                              photos[index].title,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );

    // fourth Section Catagaries
  }
}
