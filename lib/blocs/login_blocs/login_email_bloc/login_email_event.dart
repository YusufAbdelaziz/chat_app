import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginEmailEvent extends Equatable {
  const LoginEmailEvent();
}

class LoginEmailChecked extends LoginEmailEvent {
  final String email;

  LoginEmailChecked({@required this.email});
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return 'LoginEmailChecked  {email : $email}';
  }
}
