import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class SignUpEmailEvent extends Equatable {
  const SignUpEmailEvent();
}

class SignUpEmailChecked extends SignUpEmailEvent {
  final String email;

  SignUpEmailChecked({@required this.email});
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return 'SignUpEmailChecked  {email : $email}';
  }
}
