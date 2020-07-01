import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatapp/api/auth_repository.dart';
import 'package:chatapp/models/user.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final User _user = User.getInstance();
  LoginBloc({@required this.authRepository});
  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoggedInWithEmail) {
      try {
        yield LoadingLoginWithEmail();
        await authRepository.signInWithEmailAndPassword(
            password: event.password, email: event.email);
        print('Name : ${_user.name}');
        print('Email : ${_user.email}');
        print('Token : ${_user.token.substring(0, 8)}');
        print('ImageUrl : ${_user.imageUrl}');
        yield LoginWithEmailSuccess();
      } catch (e, stacktrace) {
        print(stacktrace);
        yield LoginError(errorMessage: authRepository.showErrorMessage(e.toString()));
      }
    } else if (event is LoggedInWithFacebook) {
      try {
        yield LoadingLoginWithFacebook();
        await authRepository.signInWithFacebook();
        print('Name : ${_user.name}');
        print('Email : ${_user.email}');
        print('Token : ${_user.token.substring(0, 8)}');
        print('ImageUrl : ${_user.imageUrl}');
        yield LoginWithFacebookSuccess();
      } catch (e, stacktrace) {
        print(stacktrace);
        yield LoginError(errorMessage: e.toString());
      }
    } else if (event is LoggedInWithGoogle) {
      try {
        yield LoadingLoginWithGoogle();
        await authRepository.signInWithGoogle();
        print('Name : ${_user.name}');
        print('Email : ${_user.email}');
        print('Token : ${_user.token.substring(0, 8)}');
        print('ImageUrl : ${_user.imageUrl}');
        yield LoginWithGoogleSuccess();
      } catch (e, stacktrace) {
        print(stacktrace);
        print(e.toString());
        yield LoginError(errorMessage: authRepository.showErrorMessage(e.toString()));
      }
    }
  }
}
