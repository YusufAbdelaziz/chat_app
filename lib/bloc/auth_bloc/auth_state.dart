import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class UnauthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AuthState {
  LoadingState();
  @override
  List<Object> get props => [];
}

class ValidationEmailState extends AuthState {
  @override
  List<Object> get props => [];
}

class LogoutSuccess extends AuthState {
  @override
  List<Object> get props => [];
}

class ErrorState extends AuthState {
  final String errorMessage;

  ErrorState({@required this.errorMessage});
  @override
  List<Object> get props => [];
}
