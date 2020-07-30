import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/home_page/bloc/homepage_state.dart';
import 'package:GroceryApp/home_page/bloc/hompage_event.dart';
import 'package:GroceryApp/home_page/homepage.dart';
import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  UserRepository userRepository;

  HomepageBloc({@required this.userRepository});

  @override
  HomepageState get initialState => InitHomepageState();

  @override
  Stream<HomepageState> mapEventToState(HomepageEvent event) async* {
    try {
      if (event is SubcatEvent) {
        List<dynamic> subcat = await userRepository.getSubcat(event.cat);
        yield SubcatState(subcat);
      }
      if (event is InitStartEvent) {
         
        yield InitHomepageState();
      }

      if(event is AddProductToCart){
       userRepository.addToCart(event.productId);
       yield InitHomepageState();
      }
      if (event is ProductListEvent) {
        yield HomepageLoadingState();
         List<Product> products =   await userRepository.getProductList(event.cat,event.subcat);
        yield HomepageProductListState(products: products);
      }
    } catch (e) {
      print(e);
      yield HomepageExceptionState();
    }
  }
}
