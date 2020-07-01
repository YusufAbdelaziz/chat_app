import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:chatapp/utilities/validators.dart';
import 'bloc.dart';

class LoginEmailBloc extends Bloc<LoginEmailEvent, LoginEmailState> {
  @override
  LoginEmailState get initialState => InitialLoginEmailState(errorText: null);

  @override
  Stream<LoginEmailState> mapEventToState(
    LoginEmailEvent event,
  ) async* {
    if (event is LoginEmailChecked) {
      if (Validators.isValidEmail(event.email)) {
        yield InitialLoginEmailState(errorText: null);
      } else {
        yield InvalidLoginEmail(errorText: 'Invalid Email');
      }
    }
  }

  /// This overridden method is used to make some latency and cancel the previous events, as every
  /// character is written, [mapEventToState] is called.
  @override
  Stream<Transition<LoginEmailEvent, LoginEmailState>> transformEvents(
      Stream<LoginEmailEvent> events,
      TransitionFunction<LoginEmailEvent, LoginEmailState> transitionFn) {
    return super.transformEvents(events.debounceTime(Duration(milliseconds: 400)), transitionFn);
  }
}
