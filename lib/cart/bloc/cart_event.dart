import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CartEvent extends Equatable {}

class ProductsCartEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

class IncreaseCartProductEvent extends CartEvent {
  final String productId;

  IncreaseCartProductEvent({@required this.productId});
  @override
  List<Object> get props => [productId];
}

class DecreaseCartProductEvent extends CartEvent {
  final String productId;

  DecreaseCartProductEvent({@required this.productId});
  @override
  List<Object> get props => [productId];
}
class RemoveCartProductEvent extends CartEvent {
  final String productId;

  RemoveCartProductEvent({@required this.productId});
  @override
  List<Object> get props => [productId];
}