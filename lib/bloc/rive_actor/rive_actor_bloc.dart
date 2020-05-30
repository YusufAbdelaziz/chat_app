import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class RiveActorBloc extends Bloc<RiveActorEvent, RiveActorState> {
  @override
  RiveActorState get initialState => InitialRiveActorState();

  @override
  Stream<RiveActorState> mapEventToState(
    RiveActorEvent event,
  ) async* {
    if (event is SwitchingEvent) {
      print('switch state is yielded !');

      yield SwitchingState(animationName: event.animationName);
    } else if (event is NightEvent) {
      print('night state is yielded !');

      yield NightState(animationName: event.animationName);
    } else if (event is DayEvent) {
      print('day state is yielded !');
      yield DayState(animationName: event.animationName);
    }
  }
}
