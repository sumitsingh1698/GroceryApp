import 'package:GroceryApp/home_page/homepage.dart';
import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:GroceryApp/products_view/product_view.dart';
import 'package:GroceryApp/utils/work_in_progress.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  ProductDetailPage({@required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  double containerPad;

  @override
  void initState() {
    super.initState();
    containerPad = 200;
  }

  @override
  Widget build(BuildContext context) {
   double price =double.parse(widget.product.oprice);
   double dis = double.parse(widget.product.discount);
   print(price);
   price = price - (price*dis)/100;
   print(price);
   
    return Scaffold(
      body: Container(
        child: Column(children: <Widget>[
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              child: Container(
                margin: EdgeInsets.only(top: containerPad),

                // color: Colors.yellow,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                ),
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: GestureDetector(
                              onVerticalDragUpdate: (DragUpdateDetails dud) {
                                // print(dud.localPosition.dy);
                                if (dud.localPosition.dy >= 0) {
                                  setState(() {
                                    containerPad = dud.localPosition.dy;
                                  });
                                }
                                if (dud.localPosition.dy >= 310.0) {
                                  Navigator.pop(context);
                                }
                              },
                              onVerticalDragEnd: (DragEndDetails ded) {
                                setState(() {
                                  containerPad = 200.0;
                                });
                              },
                              // onVerticalDragCancel: () {
                              //   containerPad = 1.0;
                              // },
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 70.0,
                                    child: Divider(
                                      color: Colors.black45,
                                      thickness: 5.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200.0,
                                    width: 150.0,
                                    child: Image(
                                        image: FirebaseImage(
                                            '${widget.product.imageurl}')),
                                  ),
                                ],
                              ),
                            ))),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Row(
                            // mainAxisAlignment: ,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text(
                                    widget.product.name +
                                        "( ${widget.product.qgiven} )",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: OutlineButton(
                                  textColor: Colors.blue,
                                  child: MediaQuery.of(context).size.width *
                                              MediaQuery.of(context)
                                                  .devicePixelRatio <
                                          500
                                      ? Icon(Icons.shopping_cart)
                                      : Container(child: Text('Add +')),
                                  borderSide: BorderSide(
                                      color: Colors.blue,
                                      style: BorderStyle.solid,
                                      width: 1),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                          
                          Container(
                            child: Text(
                              "${widget.product.pkt}Pkt",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "₹$price",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(width: 10.0,),
                                Container(
                                child: Text(
                                  "₹${widget.product.oprice}" ,
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 20.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            flex: 2,
          ),
        ]),
      ),
    );
  }
}
