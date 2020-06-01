import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class SignUpPasswordState extends Equatable {
  const SignUpPasswordState();
}

class InvalidPasswords extends SignUpPasswordState {
  final String passwordErrorText;
  final String reEnterErrorText;

  InvalidPasswords({@required this.passwordErrorText, @required this.reEnterErrorText});

  @override
  List<Object> get props => [];
  @override
  String toString() {
    return 'InvalidPassword {passwordErrorText : $passwordErrorText , reEnterErrorText : $reEnterErrorText}';
  }
}

class ValidSignUpPasswords extends SignUpPasswordState {
  final String passwordErrorText;
  final String reEnterErrorText;

  ValidSignUpPasswords({@required this.passwordErrorText, @required this.reEnterErrorText});
  @override
  List<Object> get props => [];
}

class UnusedState extends SignUpPasswordState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
