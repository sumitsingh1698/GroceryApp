import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:meta/meta.dart';

abstract class SearchSystemState {}

class InitSeachSystemState extends SearchSystemState {}

class SuccessSerachSystemState extends SearchSystemState {
  List<Product> products;

  SuccessSerachSystemState({@required this.products});
}

class ExceptionSearchSystemState extends SearchSystemState {}

class LoadingSearchSystemState extends SearchSystemState {}
