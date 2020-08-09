import 'package:flutter/widgets.dart';

class Order {
  var orderId;
  var custormerId;
  double orderPrice;
  DateTime orderDateTime;
  List<dynamic> products;

  int statusCode;
  int paymentStatusCode;
  var paymentId;

  Order(
      {@required this.orderId,
      @required this.orderPrice,
      @required this.statusCode,
      @required this.orderDateTime,
      @required this.paymentStatusCode,
      @required this.paymentId,
      @required this.products,
      @required this.custormerId});
}
