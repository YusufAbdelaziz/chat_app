import 'package:equatable/equatable.dart';

abstract class PasswordVisibilityState extends Equatable {
  const PasswordVisibilityState();
}

class InitialPasswordVisibilityState extends PasswordVisibilityState {
  @override
  List<Object> get props => [];
}

class PasswordVisibilityOn extends PasswordVisibilityState {
  @override
  List<Object> get props => [];
}
