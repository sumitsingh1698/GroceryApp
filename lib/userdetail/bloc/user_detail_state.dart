import 'package:meta/meta.dart';

@immutable
abstract class UserDetailState {}

class InitialUserDetailState extends UserDetailState {}

class SuccessSubmitedState extends UserDetailState {}

class ExceptionState extends UserDetailState {
  String message;

  ExceptionState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class UpdateAddressState extends UserDetailState{}

class LoadingState extends UserDetailState {}

class InternetNotConnectState extends UserDetailState{
  @override
  List<Object> get props => [];

}
