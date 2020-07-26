import 'package:GroceryApp/products_view/bloc/product_view_event.dart';
import 'package:GroceryApp/products_view/bloc/product_view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductViewBloc extends Bloc<ProductViewEvent,ProductViewState>{
  @override
  ProductViewState get initialState => InitProductViewState();

  @override
  Stream<ProductViewState> mapEventToState(ProductViewEvent event) async* {
   if(event is ProductViewEvent){
     yield ProductInRowState();
   }
  }
 
}