import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chatapp/utilities/validators.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class SignUpNameBloc extends Bloc<SignUpNameEvent, SignUpNameState> {
  @override
  SignUpNameState get initialState => ValidSignUpName(errorText: null);

  @override
  Stream<SignUpNameState> mapEventToState(
    SignUpNameEvent event,
  ) async* {
    if (event is SignUpNameChecked) {
      if (Validators.isValidName(event.name)) {
        yield ValidSignUpName(errorText: null);
      } else {
        yield InvalidSignUpName(errorText: Validators.errorNameText);
      }
    }
  }

  @override
  Stream<Transition<SignUpNameEvent, SignUpNameState>> transformEvents(
      Stream<SignUpNameEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(Duration(milliseconds: 500)), transitionFn);
  }
}
