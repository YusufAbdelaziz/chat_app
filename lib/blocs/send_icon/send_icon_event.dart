import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SendIconEvent extends Equatable {
  const SendIconEvent();
}

class ColorSwitched extends SendIconEvent {
  final bool isColorSwitched;

  ColorSwitched({@required this.isColorSwitched});

  @override
  List<Object> get props => [];
}
