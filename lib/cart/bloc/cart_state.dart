import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class CartState {}

class InitCartState extends CartState {
  List<Product> products;
  List<int> cartQuantity;
  double totalPrice;
  double serviceCharge;
  DateTime dateTime;
  InitCartState(
      {@required this.products,
      @required this.totalPrice,
      @required this.serviceCharge,
      @required this.dateTime,
      @required this.cartQuantity});
}

class IncreaseCartProductState extends CartState {}

class DecreaseCartProductState extends CartState {}

class RemoveCartProductState extends CartState {}

class ExceptionCartState extends CartState {}

class NoItemInCart extends CartState {}

class NoInternetCartState extends CartState {}

class LoadingCartState extends CartState {}
