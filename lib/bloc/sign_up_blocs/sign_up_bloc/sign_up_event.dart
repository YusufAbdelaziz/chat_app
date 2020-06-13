import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignedUpWithEmail extends SignUpEvent {
  final String email;
  final String password;
  final String userName;
  SignedUpWithEmail({@required this.email, @required this.password, @required this.userName});

  @override
  List<Object> get props => [];
}
