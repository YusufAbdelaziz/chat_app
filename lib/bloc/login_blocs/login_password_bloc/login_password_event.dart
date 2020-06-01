import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginPasswordEvent extends Equatable {
  const LoginPasswordEvent();
}

class LoginPasswordChecked extends LoginPasswordEvent {
  final String password;

  LoginPasswordChecked({@required this.password});
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return 'LoginPasswordChecked  {password : $password}';
  }
}
