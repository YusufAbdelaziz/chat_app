import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class RiveActorEvent extends Equatable {
  const RiveActorEvent();
}

class SwitchingEvent extends RiveActorEvent {
  final String animationName;

  SwitchingEvent({@required this.animationName});
  @override
  List<Object> get props => [];
}

class NightEvent extends RiveActorEvent {
  final String animationName;

  NightEvent({@required this.animationName});
  @override
  List<Object> get props => [];
}

class DayEvent extends RiveActorEvent {
  final String animationName;

  DayEvent({@required this.animationName});
  @override
  List<Object> get props => [];
}
