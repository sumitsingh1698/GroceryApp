import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/products_insertion/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class MangProductBloc extends Bloc<MangProductEvent, MangProductState> {
  UserRepository _userRepository;

  MangProductBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  MangProductState get initialState => InitAddProductState();

  @override
  Stream<MangProductState> mapEventToState(MangProductEvent event) async* {
    if (event is AddProductEvent) {
      try {
        yield LoadingAddProductState();
        print(event.product.name);
        await _userRepository.addProduct(event.product);
        yield SuccessAddProductState();
      } catch (e) {
        print(" ecseption $e");
        yield ExceptionAddProductState();
      }
    }
  }
}
