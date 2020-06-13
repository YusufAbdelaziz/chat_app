import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';

import 'package:chatapp/api/auth_repository.dart';
import './bloc.dart';

/// This BLoC is responsible of tracking the authentication status of the user.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  bool isUserAuthenticated;
  bool isUserEmailVerified;
  AuthBloc({@required this.authRepository});
  @override
  AuthState get initialState => LoadingState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthChecked) {
      if (isUserAuthenticated) {
        if (isUserEmailVerified) {
          yield AuthenticatedState();
        } else {
          yield ValidationEmailState();
        }
      } else {
        yield UnauthenticatedState();
      }
    } else if (event is SignUpAuth) {
      yield ValidationEmailState();
    } else if (event is SignInAuth) {
      try {
        /// In case of the user is being authenticated after signing up, signing in with
        /// social media or normal sign in, add the user data to firestore database.
        await authRepository.addUserToFirestore();
        yield AuthenticatedState();
      } catch (e, stacktrace) {
        print('LoggedOut stack trace --> ${stacktrace.toString()}');
        yield ErrorState(errorMessage: 'Can\'t sign in, check internet connection !');
      }
    } else if (event is SplashScreenLoaded) {
      yield LoadingState();

      /// Determine whether the user is authenticated or his email is verified after signing up while
      /// splash screen is loading.
      isUserAuthenticated = await authRepository.isUserAuthenticated();
      isUserEmailVerified = authRepository.isUserEmailVerified();
    } else if (event is LoggedOut) {
      try {
        await authRepository.logOut();
        yield LogoutSuccess();
      } catch (e, stacktrace) {
        print('LoggedOut stack trace --> ${stacktrace.toString()}');
        yield ErrorState(errorMessage: 'Can\'t log out, check internet connection !');
      }
    }
  }
}
