import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

/// Changes the send icon color so the user knows that he is able to send his message because he
/// shouldn't send an empty spaces.
class SendIconBloc extends Bloc<SendIconEvent, SendIconState> {
  @override
  SendIconState get initialState => InitialSendIconState();

  @override
  Stream<SendIconState> mapEventToState(
    SendIconEvent event,
  ) async* {
    if (event is ColorSwitched) {
      if (event.isColorSwitched) {
        yield IconColored();
      } else {
        yield InitialSendIconState();
      }
    }
  }

  @override
  Stream<Transition<SendIconEvent, SendIconState>> transformEvents(
      Stream<SendIconEvent> events, TransitionFunction<SendIconEvent, SendIconState> transitionFn) {
    return super.transformEvents(events.debounceTime(Duration(milliseconds: 300)), transitionFn);
  }
}
