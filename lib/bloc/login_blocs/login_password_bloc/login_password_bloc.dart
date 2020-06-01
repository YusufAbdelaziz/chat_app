import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

import 'package:chatapp/utilities/validators.dart';
import 'bloc.dart';

/// This BLoC makes sure that the password is strong and valid with the help of regular expression.
class LoginPasswordBloc extends Bloc<LoginPasswordEvent, LoginPasswordState> {
  @override
  LoginPasswordState get initialState => InitialLoginPasswordState(errorText: null);

  @override
  Stream<LoginPasswordState> mapEventToState(
    LoginPasswordEvent event,
  ) async* {
    if (event is LoginPasswordChecked) {
      if (Validators.isValidPassword(event.password)) {
        yield InitialLoginPasswordState(errorText: null);
      } else {
        yield InvalidLoginPassword(
            errorText: 'Password should contain upper, lower\ncharacters and numbers.');
      }
    }
  }

  /// This overridden method is used to make some latency and cancel the previous events, as every
  /// character is written, [mapEventToState] is called.
  @override
  Stream<Transition<LoginPasswordEvent, LoginPasswordState>> transformEvents(
      Stream<LoginPasswordEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(Duration(milliseconds: 400)), transitionFn);
  }
}
