import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chatapp/api/auth_repository.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc({@required this.authRepository});
  @override
  SignUpState get initialState => InitialSignUpState();

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignedUpWithEmail) {
      yield LoadingSignUpWithEmail();
      try {
        await authRepository.signUpWithEmailAndPassword(
            email: event.email, password: event.password, userName: event.userName);

        yield SignUpWithEmailSuccess();
      } catch (e) {
        yield SignUpError(errorMessage: authRepository.showErrorMessage(e.toString()));
        yield InitialSignUpState();
      }
    }
  }
}
