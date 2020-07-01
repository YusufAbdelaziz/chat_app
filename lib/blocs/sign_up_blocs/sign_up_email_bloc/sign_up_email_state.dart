import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class SignUpEmailState extends Equatable {
  const SignUpEmailState();
}

class ValidSignUpEmail extends SignUpEmailState {
  final String errorText;

  ValidSignUpEmail({@required this.errorText});
  @override
  String toString() {
    return 'InitialSignUpEmailState {errorText : $errorText}';
  }

  @override
  List<Object> get props => [];
}

class InvalidSignUpEmail extends SignUpEmailState {
  final String errorText;

  InvalidSignUpEmail({@required this.errorText});
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return 'InvalidSignUpEmail {errorText : $errorText}';
  }
}
