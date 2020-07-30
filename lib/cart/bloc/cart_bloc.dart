import 'package:GroceryApp/cart/bloc/cart_event.dart';
import 'package:GroceryApp/cart/bloc/cart_state.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final UserRepository userRepository;

  @override
  CartState get initialState => LoadingCartState();

  CartBloc({@required this.userRepository});

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is IncreaseCartProductEvent) {
      userRepository.userDetail.insertInCartQuantity(event.productId);
      yield LoadingCartState();
    }
    if (event is DecreaseCartProductEvent) {
      userRepository.userDetail.removeInCartQuantity(event.productId);
      yield LoadingCartState();
    }
    if (event is RemoveCartProductEvent) {
      userRepository.deleteToCart(event.productId);
      yield LoadingCartState();
    } else if (event is ProductsCartEvent) {
      List<Product> products;
      List<int> _cartItem = userRepository.userDetail.getCartQuantity;
      double totalPrice = 0.0;
      double serviceCharge = 25.0;
      int waitingDays = 3;

      DateTime dateTime = DateTime.now().add(Duration(days: waitingDays));
      try {
        products = await userRepository.getProductsForCart();

        print(products.length);
      } catch (e) {
        print('$e');
      }
      if (products.length == 0) {
        yield NoItemInCart();
      } else {
        double price;
        double dis;
        // print(price);

        for (int i = 0; i < products.length; i++) {
          price = double.parse(products[i].oprice);
          dis = double.parse(products[i].discount);
          price = price - (price * dis) / 100;
          totalPrice += (price * _cartItem[i]);
        }

        yield InitCartState(
            cartQuantity: _cartItem,
            dateTime: dateTime,
            products: products,
            totalPrice: totalPrice,
            serviceCharge: serviceCharge);
      }
    }
  }
}
