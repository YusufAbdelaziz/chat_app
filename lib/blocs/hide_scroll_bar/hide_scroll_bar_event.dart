import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class HideScrollBarEvent extends Equatable {
  const HideScrollBarEvent();
}

class ShowOrHideScrollBarEvent extends HideScrollBarEvent {
  final bool isScrollbarShown;

  ShowOrHideScrollBarEvent({@required this.isScrollbarShown});

  @override
  List<Object> get props => [];
}
