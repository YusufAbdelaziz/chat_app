import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoggedInWithFacebook extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoggedInWithGoogle extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoggedInWithEmail extends LoginEvent {
  final String email;
  final String password;

  LoggedInWithEmail({@required this.email, @required this.password});
  @override
  List<Object> get props => [];
}
