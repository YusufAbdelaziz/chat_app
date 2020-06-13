import 'package:equatable/equatable.dart';

abstract class EmailValidationEvent extends Equatable {
  const EmailValidationEvent();
}

class EmailValidationChecked extends EmailValidationEvent {
  @override
  List<Object> get props => [];
}

class EmailValidationSent extends EmailValidationEvent {
  @override
  List<Object> get props => [];
}
