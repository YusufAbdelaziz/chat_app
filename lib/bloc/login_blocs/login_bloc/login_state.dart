import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingLoginWithFacebook extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingLoginWithGoogle extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingLoginWithEmail extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginWithEmailSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginWithFacebookSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginWithGoogleSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError({@required this.errorMessage});
  @override
  List<Object> get props => [];
}
