import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthChecked extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignInAuth extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignUpAuth extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SplashScreenLoaded extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoggedOut extends AuthEvent {
  @override
  List<Object> get props => [];
}
