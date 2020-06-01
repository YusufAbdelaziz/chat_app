import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginPasswordState extends Equatable {
  const LoginPasswordState();
}

class InitialLoginPasswordState extends LoginPasswordState {
  final String errorText;

  InitialLoginPasswordState({@required this.errorText});
  @override
  String toString() {
    return 'InitialLoginPasswordState {errorText : $errorText}';
  }

  @override
  List<Object> get props => [];
}

class InvalidLoginPassword extends LoginPasswordState {
  final String errorText;

  InvalidLoginPassword({@required this.errorText});
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return 'InvalidLoginPassword {errorText : $errorText}';
  }
}
