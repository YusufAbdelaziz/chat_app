import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class EmailValidationState extends Equatable {
  const EmailValidationState();
}

class InitialEmailValidationState extends EmailValidationState {
  @override
  List<Object> get props => [];
}

class ValidationEmailSuccess extends EmailValidationState {
  @override
  List<Object> get props => [];
}

class ValidationEmailError extends EmailValidationState {
  final String errorMessage;

  ValidationEmailError({@required this.errorMessage});
  @override
  List<Object> get props => [];
}

class ValidationEmailLoading extends EmailValidationState {
  @override
  List<Object> get props => [];
}

class ValidationEmailSent extends EmailValidationState {
  @override
  List<Object> get props => [];
}
