import 'package:GroceryApp/home_page/bloc/hompage_bloc.dart';
import 'package:GroceryApp/home_page/bloc/hompage_event.dart';
import 'package:GroceryApp/home_page/models/photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageThirdSection extends StatelessWidget {
  final List<Photo> photos = <Photo>[
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
    return SliverGrid(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1,
          crossAxisCount: orientation == Orientation.portrait ? 3 : 5),
      delegate: new SliverChildBuilderDelegate(
        
        (BuildContext context, int index) {
          return new GestureDetector(
            onTap: () {
              BlocProvider.of<HomepageBloc>(context)
                  .add(SubcatEvent(cat: photos[index].title.toLowerCase()));
            },

            child: Container(
                padding: EdgeInsets.only(top:20.0),
              child: Stack(
                 alignment: Alignment.bottomCenter,
                children: <Widget>[
                   Container(
                     padding: EdgeInsets.only(bottom:20.0,left:20.0,right:20.0,),
                     child: SizedBox(
                      
                  width: double.infinity,
                  height: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        photos[index].assetName,
                        fit: BoxFit.cover,
                      ),
                  ),
                
                ),
                   ),
                Text("${photos[index].title}",style: TextStyle(fontSize: 14),)
                ],
              ),
            ),

            // child: new Container(
            //   padding: EdgeInsets.all(15.0),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //     color: Colors.white
            //   ),
            //   //  mainAxisSize: MainAxisSize.max,
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: Stack(
            //       children: <Widget>[
            //         Positioned.fill(

            //             child: Container(
            //               color: Colors.white,
            //           child: ClipRRect(
            //             borderRadius: BorderRadius.circular(20.0),
            //                                       child: Image.asset(
            //               photos[index].assetName,
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         )
            //         ),
            //       Text(
            //               photos[index].title,
            //               style: TextStyle(
            //                 fontSize: 20.0,
            //                 color: Colors.white,
            //               ),
            //             ),
            //         Container(
            //           //margin: EdgeInsets.only(left: 10.0),
            //           padding: EdgeInsets.only(left: 3.0, bottom: 3.0),
            //           alignment: Alignment.bottomLeft,
            //           child: new GestureDetector(
            //             onTap: () {
            //               BlocProvider.of<HomepageBloc>(context).add(
            //                   SubcatEvent(
            //                       cat: photos[index].title.toLowerCase()));
            //             },
            //             child: new Text(
            //               photos[index].title,
            //               style: TextStyle(
            //                 fontSize: 20.0,
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          );
        },
        childCount: photos.length,
      ),
    );

    // fourth Section Catagaries
  }
}
