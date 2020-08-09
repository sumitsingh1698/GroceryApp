import 'package:GroceryApp/orders/models/order.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class OrderState extends Equatable {}

class OrderListState extends OrderState {
  final List<Order> orders;

  OrderListState({@required this.orders});

  @override
  List<Object> get props => [orders];
}

class OrderLoadingState extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderExceptionState extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderNoInternetState extends OrderState {
  @override
  List<Object> get props => [];
}
