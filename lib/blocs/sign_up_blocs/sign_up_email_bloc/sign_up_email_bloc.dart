import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chatapp/utilities/validators.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class SignUpEmailBloc extends Bloc<SignUpEmailEvent, SignUpEmailState> {
  @override
  SignUpEmailState get initialState => ValidSignUpEmail(errorText: null);

  @override
  Stream<SignUpEmailState> mapEventToState(
    SignUpEmailEvent event,
  ) async* {
    if (event is SignUpEmailChecked) {
      if (Validators.isValidEmail(event.email)) {
        yield ValidSignUpEmail(errorText: null);
      } else {
        yield InvalidSignUpEmail(errorText: 'Invalid Email');
      }
    }
  }

  /// This overridden method is used to make some latency and cancel the previous events, as every
  /// character is written, [mapEventToState] is called.
  @override
  Stream<Transition<SignUpEmailEvent, SignUpEmailState>> transformEvents(
      Stream<SignUpEmailEvent> events,
      TransitionFunction<SignUpEmailEvent, SignUpEmailState> transitionFn) {
    return super.transformEvents(events.debounceTime(Duration(milliseconds: 300)), transitionFn);
  }
}
