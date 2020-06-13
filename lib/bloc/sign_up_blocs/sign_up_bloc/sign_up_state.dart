import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class InitialSignUpState extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpWithEmailSuccess extends SignUpState {
  @override
  List<Object> get props => [];
}

class LoadingSignUpWithEmail extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpError extends SignUpState {
  final String errorMessage;

  SignUpError({@required this.errorMessage});
  @override
  List<Object> get props => [];
}
