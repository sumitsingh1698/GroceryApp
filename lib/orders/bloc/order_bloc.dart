import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/login/bloc/login_state.dart';
import 'package:GroceryApp/orders/bloc/order_event.dart';
import 'package:GroceryApp/orders/bloc/order_state.dart';
import 'package:GroceryApp/orders/models/order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final UserRepository userRepository;

  OrderBloc({@required this.userRepository});

  @override
  OrderState get initialState => OrderLoadingState();

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is GetOrdersEvent) {
      List<Order> orders;
      try {
        // await userRepository.updateOrdersOfUser();
        orders = await userRepository.getAllOrderDetails();
        yield OrderListState(orders: orders);
      } catch (e) {
        print(e);
        yield OrderExceptionState();
      }
      // print("order the length :${orders.length}");
    }
  }
}
