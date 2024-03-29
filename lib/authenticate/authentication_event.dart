  import 'package:equatable/equatable.dart';
  import 'package:meta/meta.dart';

  @immutable
  abstract class AuthenticationEvent extends Equatable {
    AuthenticationEvent([List props = const []]);
  }

    class AppStarted extends AuthenticationEvent {
    @override
    String toString() => 'AppStarted';

    @override
    List<Object> get props => [];
  }

  class LoggedIn extends AuthenticationEvent {
   @override
     List<Object> get props => [];
  }

  class LoggedOut extends AuthenticationEvent {
    @override
    String toString() => 'LoggedOut';

    @override
    // TODO: implement props
    List<Object> get props => [];
  }
