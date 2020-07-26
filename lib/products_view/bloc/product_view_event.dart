import 'package:equatable/equatable.dart';

abstract class ProductViewEvent extends Equatable{} 

class ShowProductInRowEvent extends ProductViewEvent{
  @override
  List<Object> get props => [];

}



