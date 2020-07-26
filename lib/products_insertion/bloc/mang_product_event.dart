import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class MangProductEvent extends Equatable{
  @override
  List<Object> get props =>[];
  }

class AddProductEvent extends MangProductEvent{
  
  Product product;
  AddProductEvent({@required this.product});

}
