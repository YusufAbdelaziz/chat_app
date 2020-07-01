import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginEmailState extends Equatable {
  const LoginEmailState();
}

class InitialLoginEmailState extends LoginEmailState {
  final String errorText;

  InitialLoginEmailState({@required this.errorText});
  @override
  String toString() {
    return 'InitialLoginEmailState {errorText : $errorText}';
  }

  @override
  List<Object> get props => [];
}

class InvalidLoginEmail extends LoginEmailState {
  final String errorText;

  InvalidLoginEmail({@required this.errorText});
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return 'InvalidLoginEmail {errorText : $errorText}';
  }
}
