import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class SignUpNameState extends Equatable {
  const SignUpNameState();
}

class ValidSignUpName extends SignUpNameState {
  final String errorText;

  ValidSignUpName({@required this.errorText});
  @override
  List<Object> get props => [];
}

class InvalidSignUpName extends SignUpNameState {
  final String errorText;

  InvalidSignUpName({@required this.errorText});
  @override
  List<Object> get props => [];
}
