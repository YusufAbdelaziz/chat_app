import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class SignUpPasswordEvent extends Equatable {
  const SignUpPasswordEvent();
}

class PasswordChecked extends SignUpPasswordEvent {
  final String password;
  final String reEnterPassword;
  PasswordChecked({@required this.password, @required this.reEnterPassword});
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return 'PasswordChecked {password : $password , reEnterPassword : $reEnterPassword}';
  }
}
