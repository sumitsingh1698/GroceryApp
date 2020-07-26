import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/home_page/bloc/homepage_state.dart';
import 'package:GroceryApp/home_page/bloc/hompage_bloc.dart';
import 'package:GroceryApp/home_page/bloc/hompage_event.dart';
import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:GroceryApp/products_view/bloc/product_view_bloc.dart';
import 'package:GroceryApp/products_view/products_view_widgets/product_detail_page.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductView extends StatelessWidget {
  final List<Product> products;
  final UserRepository userRepository;
  ProductView({@required this.products, @required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductViewBloc>(
      create: (context) => ProductViewBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: FlatButton(
            onPressed: () {
              BlocProvider.of<HomepageBloc>(context).add(InitStartEvent());
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: ProductViewPage(products, userRepository),
      ),
    );
  }
}

class ProductViewPage extends StatefulWidget {
  final List<Product> products;
  final UserRepository userRepository;
  ProductViewPage(this.products, this.userRepository);

  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      color: Colors.white12,
      child: ListView.builder(
          itemCount: widget.products.length,
          itemBuilder: (BuildContext cont, int ind) {
            // if(ind == 0){
            //   return Container(height: 100,color: Colors.red,child: Stack(
            //     children: <Widget>[

            //       CupertinoTextField()
            //     ],
            //   ),);
            // }
            double price = double.parse(widget.products[ind].oprice);
            double dis = double.parse(widget.products[ind].discount);
            // print(price);
            price = price - (price * dis) / 100;
            // print(price);

            return SafeArea(
                child: Container(
              alignment: Alignment.topLeft,
              child: Container(
                  padding: EdgeInsets.all(1.0),
                  alignment: Alignment.topLeft,
                  child: Card(
                    elevation: 2.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailPage(
                                          product: widget.products[ind],
                                        )));
                          },
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                height: 90.0,
                                width: 90.0,
                                child: Image(
                                    image: FirebaseImage(
                                        '${widget.products[ind].imageurl}')),
                              ),
                              SizedBox(width: 15.0),
                              Container(
                                width: orientation == Orientation.landscape
                                    ? 300
                                    : 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.products[ind].name +
                                          " ( ${widget.products[ind].qgiven} )",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      widget.products[ind].pkt + " pkt",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "₹${price.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Container(
                                          child: Text(
                                            "₹${widget.products[ind].oprice}",
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 15.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        OutlineButton(
                          textColor: Colors.blue,
                          child: MediaQuery.of(context).size.width *
                                      MediaQuery.of(context).devicePixelRatio <
                                  500
                              ? Icon(Icons.shopping_cart)
                              : Container(child: Text('Add +')),
                          borderSide: BorderSide(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 1),
                          onPressed: () {
                            print('hel');
                            setState(() {
                              widget.userRepository
                                  .addToCart("${widget.products[ind].name}");
                            });
                          },
                        ),
                      ],
                    ),
                  )),
            ));
          }),
    );
  }
}
