import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PasswordVisibilityBloc extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  @override
  PasswordVisibilityState get initialState => InitialPasswordVisibilityState();

  @override
  Stream<PasswordVisibilityState> mapEventToState(
    PasswordVisibilityEvent event,
  ) async* {
    if (event is PasswordShowed) {
      yield PasswordVisibilityOn();
    } else if (event is PasswordHidden) {
      yield InitialPasswordVisibilityState();
    }
  }
}
