import 'dart:async';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './user_bloc.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserRepository _userRepository;
  
  UserDetailBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;
  
  
  @override
  UserDetailState get initialState => InitialUserDetailState();

  @override
  Stream<UserDetailState> mapEventToState(
    UserDetailEvent event,
  ) async* {
     if(event is PersonalDetailUpdateEvent){
       yield LoadingState();
      await _userRepository.updatePersonalDetails(event.email,event.fname,event.lname);
      yield UpdateAddressState();
     }if(event is AddressDetailUpdateEvent){
      yield LoadingState();
      await _userRepository.updateAddressDetails(event.hno, event.floor, event.address, event.landmark,event.pincode);
      yield SuccessSubmitedState();
     }
  }
}
