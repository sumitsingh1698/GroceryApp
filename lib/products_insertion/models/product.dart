import 'package:flutter/widgets.dart';

class Product {
  String productId;
  String name;
  String oprice;
  String discount;
  String pkt;
  String quantity;
  String qgiven;
  String scat;
  String cat;
  String imageurl;
  Product(
      { @required this.productId,
        @required this.name,
      @required this.oprice,
      @required this.discount,
      @required this.pkt,
      @required this.quantity,
      @required this.qgiven,
      @required this.scat,
      @required this.cat,
      @required this.imageurl});
}
