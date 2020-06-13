import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SignUpNameEvent extends Equatable {
  const SignUpNameEvent();
}

class SignUpNameChecked extends SignUpNameEvent {
  final String name;

  SignUpNameChecked({@required this.name});
  @override
  List<Object> get props => [];
}
