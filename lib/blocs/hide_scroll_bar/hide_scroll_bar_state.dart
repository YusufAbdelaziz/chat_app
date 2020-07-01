import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class HideScrollBarState extends Equatable {
  const HideScrollBarState();
}

class InitialHideScrollBarState extends HideScrollBarState {
  final bool isScrollbarShown;

  InitialHideScrollBarState({@required this.isScrollbarShown});
  @override
  List<Object> get props => [];
}

/// This state is just used as a transition state because we want to yield the initial state twice.
/// That's way we need to yield another state in between.
class UnusedHideScrollBarState extends HideScrollBarState {
  @override
  List<Object> get props => [];
}
