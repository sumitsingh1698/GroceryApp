import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {}

class GetOrdersEvent extends OrderEvent {
  @override
  List<Object> get props => [];
}
