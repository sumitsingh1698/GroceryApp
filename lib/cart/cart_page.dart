import 'package:GroceryApp/cart/bloc/cart_event.dart';
import 'package:GroceryApp/cart/bloc/cart_state.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/home_page/homepage.dart';
import 'package:GroceryApp/orders/order.dart';
import 'package:GroceryApp/payment/payment_page.dart';
import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cart_bloc.dart';

class CartScreenParent extends StatelessWidget {
  final UserRepository userRepository;
  CartScreenParent({@required this.userRepository});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CartBloc(userRepository: userRepository),
        child: CartScreen(userRepository));
  }
}

class CartScreen extends StatefulWidget {
  final UserRepository userRepository;
  CartScreen(this.userRepository);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc _cartBloc;

  List<String> getListOfProductId(List<Product> products) {
    List<String> productIds = new List();
    for (int i = 0; i < products.length; i++) {
      print(products[i].productId);
      productIds.add(products[i].productId.toString());
    }

    return productIds;
  }

  @override
  void initState() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    super.initState();
  }

  String getWeekDay(int day) {
    switch (day) {
      case 1:
        return "Monday";
        break;
      case 2:
        return "Tuesday";
        break;
      case 3:
        return "Wednesday";
        break;
      case 4:
        return "Thursday";
        break;
      case 5:
        return "Friday";
        break;
      case 6:
        return "Saturday";
        break;
      case 7:
        return "Sunday";
        break;
    }
    return "";
  }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return "January";
        break;
      case 2:
        return "February";
        break;
      case 3:
        return "March";
        break;
      case 4:
        return "April";
        break;
      case 5:
        return "May";
        break;
      case 6:
        return "June";
        break;
      case 7:
        return "July";
        break;
      case 8:
        return "August";
        break;
      case 9:
        return "September";
        break;
      case 10:
        return "October";
        break;
      case 11:
        return "November";
        break;
      case 12:
        return "December";
        break;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {},
      child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is LoadingCartState) {
          BlocProvider.of<CartBloc>(context).add(ProductsCartEvent());
          return Scaffold(
              body: Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Center(child: CircularProgressIndicator()),
          ));
        }
        // else if(state is IncreaseCartProductState || state is DecreaseCartProductState ||state is RemoveCartProductState ){
        //   BlocProvider.of<CartBloc>(context).add(ProductsCartEvent());
        // }
        else if (state is NoItemInCart) {
          return Scaffold(
              body: Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: AlertDialog(
              title: new Text(
                "No Product Found In Cart",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: new Text(
                'Add few Product and then come back in your Cart',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                new FlatButton(
                  child: Text("BACK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ));
        }
        if (state is InitCartState) {
          double checkoutAmmount = state.totalPrice + state.serviceCharge;
          List<Product> products = state.products;
          return Scaffold(
              bottomNavigationBar: BottomAppBar(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentPage(
                                      phoneNo:
                                          "${widget.userRepository.userDetail.getPhoneNo}",
                                      email: widget
                                          .userRepository.userDetail.getEmail,
                                      order: Order(
                                          custormerId: widget
                                              .userRepository.userDetail.getUid,
                                          orderId: "1",
                                          orderDateTime: DateTime.now(),
                                          orderPrice: checkoutAmmount,
                                          paymentStatus: "pending",
                                          deliveryStatus: "progress",
                                          products:
                                              getListOfProductId(products)),
                                    )));
                      },
                      child: Text(
                        "\₹ $checkoutAmmount to Checkout",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColorDark),
                ),
              ),
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.backspace),
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.centerLeft,
                  tooltip: 'Back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text("MY CART (${state.products.length})"),
                backgroundColor: Colors.white,
                actions: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Container(
                      child: new GestureDetector(
                        onTap: () {},
                        child: Stack(children: <Widget>[
                          new IconButton(
                              icon: new Icon(
                                Icons.home,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomepageParent(
                                            widget.userRepository)));
                              }),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
              body: Container(
                color: Theme.of(context).accentColor.withOpacity(0.3),
                child: ListView.builder(
                    itemCount: products.length + 2,
                    itemBuilder: (BuildContext cont, int ind) {
                      if (ind == 0) {
                        return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 8.0,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            ),
                            padding: EdgeInsets.all(30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Deliver On"),
                                Text(
                                  "${getWeekDay(state.dateTime.weekday)}, ${getMonth(state.dateTime.month)} ${state.dateTime.day}",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ));
                      } else if (ind == products.length + 1) {
                        return SafeArea(
                            child: Container(
                                padding: EdgeInsets.all(7.0),
                                child: Card(
                                    elevation: 3.0,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("Cart Amount :"),
                                              Text("\₹ ${state.totalPrice}"),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("Service Fee"),
                                              Text("\₹ 25"),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Divider(
                                          thickness: 2.0,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("Amount to Pay"),
                                              Text("\₹ $checkoutAmmount"),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ))));
                      }
                      double price = double.parse(products[ind - 1].oprice);
                      double dis = double.parse(products[ind - 1].discount);
                      // print(price);
                      price = price - (price * dis) / 100;

                      return SafeArea(
                          child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(7.0),
                                alignment: Alignment.topLeft,
                                child: Card(
                                  elevation: 3.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 90.0,
                                            width: 90.0,
                                            child: Image(
                                                image: FirebaseImage(
                                                    '${products[ind - 1].imageurl}')),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        MediaQuery.of(context)
                                                            .devicePixelRatio <
                                                    500
                                                ? 50
                                                : 180,
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                    "${products[ind - 1].name} (${state.cartQuantity[ind - 1]})",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black),
                                                    textAlign:
                                                        TextAlign.center),
                                                SizedBox(height: 25.0),
                                                Text(
                                                  "$price",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                              padding: EdgeInsets.all(10.0),
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.grey,
                                                  ),
                                                  onPressed: () {
                                                    BlocProvider.of<CartBloc>(
                                                            context)
                                                        .add(RemoveCartProductEvent(
                                                            productId: products[
                                                                    ind - 1]
                                                                .productId));
                                                  })),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              new IconButton(
                                                icon: Icon(Icons.add_circle,
                                                    color: Theme.of(context)
                                                        .primaryColorDark),
                                                onPressed: () {
                                                  BlocProvider.of<CartBloc>(
                                                          context)
                                                      .add(IncreaseCartProductEvent(
                                                          productId:
                                                              products[ind - 1]
                                                                  .productId));

                                                  // widget.userRepository.userDetail.insertInCartQuantity(products[ind - 1].productId);
                                                  // print(products[ind - 1])
                                                  // item = item + 1;
                                                },
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 2.0),
                                              ),
                                              // Text(
                                              //   item.toString(),
                                              // ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 2.0),
                                              ),
                                              new IconButton(
                                                icon: Icon(Icons.remove_circle),
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                onPressed: () {
                                                  BlocProvider.of<CartBloc>(
                                                          context)
                                                      .add(DecreaseCartProductEvent(
                                                          productId:
                                                              products[ind - 1]
                                                                  .productId));
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ));
                    }),
              ));
        }
      }),
    );
  }
}
