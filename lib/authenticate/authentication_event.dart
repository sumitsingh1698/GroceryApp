  import 'package:equatable/equatable.dart';
  import 'package:meta/meta.dart';

  @immutable
  abstract class AuthenticationEvent extends Equatable {
    AuthenticationEvent([List props = const []]);
  }
    // When Apps trigger this Event will trigger : 
    class AppStarted extends AuthenticationEvent {
    @override
    String toString() => 'AppStarted';

    @override
    List<Object> get props => [];
  }
  // When LoggedIn Event : 
  class LoggedIn extends AuthenticationEvent {
   @override
     List<Object> get props => [];
  }
  // Loggout Event :
  class LoggedOut extends AuthenticationEvent {
    @override
    String toString() => 'LoggedOut';
    
    @override
    List<Object> get props => [];
  }
