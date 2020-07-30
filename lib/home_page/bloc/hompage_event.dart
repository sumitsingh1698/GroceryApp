import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class HomepageEvent extends Equatable{}


// find sub categories of Categories --
class SubcatEvent extends HomepageEvent{
  final String cat;

  SubcatEvent({@required this.cat});
  @override
  List<Object> get props => [cat];
}

//intial state of categoies 
class InitStartEvent extends HomepageEvent{
  @override
  List<Object> get props => [];
}

// find the list of product from catogories
class ProductListEvent extends HomepageEvent{
  
  final String cat ;
  final String subcat;

  ProductListEvent({@required this.cat,@required this.subcat});
   
  @override
  List<Object> get props => [cat,subcat];

}

class AddProductToCart extends HomepageEvent{
 final String productId;
 final String quantity;
AddProductToCart({@required this.productId,@required this.quantity});
  @override
  List<Object> get props => [productId];

}

