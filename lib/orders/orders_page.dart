import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/orders/bloc/order_bloc.dart';
import 'package:GroceryApp/orders/bloc/order_event.dart';
import 'package:GroceryApp/orders/bloc/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderParent extends StatelessWidget {
  final UserRepository userRepository;

  OrderParent({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(userRepository: userRepository),
      child: OrderPage(userRepository),
    );
  }
}

class OrderPage extends StatefulWidget {
  final UserRepository userRepository;
  OrderPage(this.userRepository, {Key key}) : super(key: key);
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Orders", style: TextStyle(color: Colors.white))),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {},
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoadingState) {
              BlocProvider.of<OrderBloc>(context).add((GetOrdersEvent()));

              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is OrderListState) {
              if (state.orders.length == 0) {
                return Container(
                  child: Center(
                    child: Text("No Order Found !!"),
                  ),
                );
              }

              return Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    Map<String, dynamic> getPaymentDetail =
                        getPaymentStatusMessage(
                            state.orders[index].paymentStatusCode);
                    Map<String, dynamic> getStatusDetail =
                        getStatusMessage(state.orders[index].statusCode);

                    return GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            child: AlertDialog(
                              actions: <Widget>[
                                RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Back"),
                                )
                              ],
                              title: Text(
                                "Order On ${state.orders[index].orderDateTime.day}.${state.orders[index].orderDateTime.month}.${state.orders[index].orderDateTime.year} at ${state.orders[index].orderDateTime.hour} : ${state.orders[index].orderDateTime.minute % 60}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              contentPadding: EdgeInsets.all(20.0),
                              content: Container(
                                height: 300,
                                width: 300,
                                child: ListView.separated(
                                  separatorBuilder: (context, indexSep) {
                                    return Divider();
                                  },
                                  itemBuilder: (context, indexList) {
                                    if (indexList == 0) {
                                      return Text(
                                          "Order Id : ${state.orders[index].orderId}");
                                    } else if (indexList == 1) {
                                      return Text(
                                          "Payment Id : ${state.orders[index].paymentId}");
                                    } else if (indexList == 2) {
                                      return Text(
                                        "${state.orders[index].products.length} Product was Ordered in ${state.orders[index].orderPrice}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      );
                                    }

                                    return Text(
                                      "${state.orders[index].products[indexList - 3]['name']} : ${state.orders[index].products[indexList - 3]['quantity']} Packets",
                                      textAlign: TextAlign.start,
                                    );
                                  },
                                  itemCount:
                                      3 + state.orders[index].products.length,
                                ),
                              ),
                            ));
                      },
                      child: Card(
                          elevation: 3.0,
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.5)),
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                              "${state.orders[index].orderDateTime.day}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                          Text(
                                            getMonth(state.orders[index]
                                                .orderDateTime.month),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "${state.orders[index].orderDateTime.year}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "${state.orders[index].products.length} Products",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "₹${state.orders[index].orderPrice}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.5)),
                                        ),
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          "Payment : ${getPaymentDetail['message']}",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: getStatusDetail['color'],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.5)),
                                    ),
                                    child: Text(
                                      "${getStatusDetail['message']}",
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    );
                  },
                  itemCount: state.orders.length,
                ),
              );
            }
            return Container(
              child: Center(
                child: Text("Error"),
              ),
            );
          },
        ),
      ),
    );
  }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
        break;
      case 2:
        return "Feb";
        break;
      case 3:
        return "Mar";
        break;
      case 4:
        return "Apr";
        break;
      case 5:
        return "May";
        break;
      case 6:
        return "Jun";
        break;
      case 7:
        return "Jul";
        break;
      case 8:
        return "Aug";
        break;
      case 9:
        return "Sep";
        break;
      case 10:
        return "Oct";
        break;
      case 11:
        return "Nov";
        break;
      case 12:
        return "Dec";
        break;
    }
    return "";
  }

  Map<String, dynamic> getPaymentStatusMessage(int code) {
    switch (code) {
      case 11:
        return {"message": "Successfully Received", "color": Colors.yellow};
        break;
      case 12:
        return {"message": "COD", "color": Colors.yellowAccent};
        break;
      case 13:
        return {"message": "Payment Cancel", "color": Colors.redAccent};
        break;
      case 14:
        return {"message": "Payment Waiting", "color": Colors.blue};
        break;
      default:
    }
    return {"message": "Error", "color": Colors.red};
  }

  Map<String, dynamic> getStatusMessage(int code) {
    switch (code) {
      case 21:
        return {"message": "Order Accepted", "color": Colors.amber};
        break;
      case 22:
        return {
          "message": "Order Way to Delivery",
          "color": Colors.amberAccent
        };
        break;
      case 23:
        return {"message": "Order Cancel", "color": Colors.redAccent};
        break;
      case 24:
        return {
          "message": "Order Successfully Delivered",
          "color": Colors.green
        };
        break;
      case 25:
        return {
          "message": "Order Confirmation Waiting",
          "color": Colors.blueAccent
        };
        break;
      default:
    }
    return {"message": "Error", "color": Colors.red};
  }
}
