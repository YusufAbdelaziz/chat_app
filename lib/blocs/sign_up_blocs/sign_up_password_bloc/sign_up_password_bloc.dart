import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';
import 'package:chatapp/utilities/validators.dart';

class SignUpPasswordBloc extends Bloc<SignUpPasswordEvent, SignUpPasswordState> {
  final rePasswordErrorMsg = 'Re-enter the password correctly.';
  final passwordErrorMsg = Validators.errorPasswordText;
  @override
  SignUpPasswordState get initialState =>
      ValidSignUpPasswords(passwordErrorText: null, reEnterErrorText: null);

  @override
  Stream<SignUpPasswordState> mapEventToState(
    SignUpPasswordEvent event,
  ) async* {
    if (event is PasswordChecked) {
      if (Validators.isValidPassword(event.password)) {
        if (event.password == event.reEnterPassword) {
          yield ValidSignUpPasswords(passwordErrorText: null, reEnterErrorText: null);
        } else {
          yield UnusedState();
          yield InvalidPasswords(reEnterErrorText: rePasswordErrorMsg, passwordErrorText: null);
        }
      } else {
        yield UnusedState();
        yield InvalidPasswords(
            reEnterErrorText: rePasswordErrorMsg, passwordErrorText: passwordErrorMsg);
      }
    }
  }

  @override
  Stream<Transition<SignUpPasswordEvent, SignUpPasswordState>> transformEvents(
      Stream<SignUpPasswordEvent> events,
      TransitionFunction<SignUpPasswordEvent, SignUpPasswordState> transitionFn) {
    return super.transformEvents(events.debounceTime(Duration(milliseconds: 500)), transitionFn);
  }
}
