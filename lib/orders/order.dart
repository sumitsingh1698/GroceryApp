import 'package:flutter/widgets.dart';

class Order{
  var orderId;
  var customerId;
  double orderPrice;
  DateTime orderDateTime;
  List<String> products;

  var deliveryStatus;
  var paymentStatus;

  Order({@required this.orderId,
  @required this.orderPrice,
  @required this.deliveryStatus,
  @required this.orderDateTime,
  @required this.paymentStatus,
  @required this.products});
}