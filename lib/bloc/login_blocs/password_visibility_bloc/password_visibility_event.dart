import 'package:equatable/equatable.dart';

abstract class PasswordVisibilityEvent extends Equatable {
  const PasswordVisibilityEvent();
}

class PasswordShowed extends PasswordVisibilityEvent {
  @override
  List<Object> get props => [];
}

class PasswordHidden extends PasswordVisibilityEvent {
  @override
  List<Object> get props => [];
}
