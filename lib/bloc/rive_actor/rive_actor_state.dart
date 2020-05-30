import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class RiveActorState extends Equatable {
  const RiveActorState();
}

class InitialRiveActorState extends RiveActorState {
  @override
  List<Object> get props => [];
}

class NightState extends RiveActorState {
  final String animationName;

  NightState({@required this.animationName});

  @override
  List<Object> get props => [];
}

class DayState extends RiveActorState {
  final String animationName;

  DayState({@required this.animationName});

  @override
  List<Object> get props => [];
}

class SwitchingState extends RiveActorState {
final String animationName;

SwitchingState({@required this.animationName});

@override
List<Object> get props => [];
}
