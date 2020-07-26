import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:meta/meta.dart';

abstract class HomepageState {}

//init state of homepage
class InitHomepageState extends HomepageState{}


class SubcatState extends HomepageState{
  List<dynamic> subcat;
  SubcatState(this.subcat);
}

class HomepageProductListState extends HomepageState{
  List<Product> products;
  HomepageProductListState({@required this.products});
}

class HomepageExceptionState extends HomepageState{}

class HomepageLoadingState extends HomepageState{}

class NoInternetState extends HomepageState{}