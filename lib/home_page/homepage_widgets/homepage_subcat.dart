import 'package:GroceryApp/home_page/bloc/hompage_bloc.dart';
import 'package:GroceryApp/home_page/bloc/hompage_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageSubcatSection extends StatelessWidget {
  final List<dynamic> subcats;

  HomePageSubcatSection({this.subcats});

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return SliverGrid(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 3 : 5),
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {
                BlocProvider.of<HomepageBloc>(context)
                    .add(ProductListEvent(cat: "milk", subcat: "Toned"));

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ProductView(
                //         )));
              },
              child: new Container(
                padding: EdgeInsets.all(12.0),
                //  mainAxisSize: MainAxisSize.max,
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        //margin: EdgeInsets.only(left: 10.0),

                        alignment: Alignment.center,
                        child: new Text(
                          subcats[index].toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
        childCount: subcats.length,
      ),
    );
  }
}
