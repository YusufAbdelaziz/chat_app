import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AddFriendState extends Equatable {
  const AddFriendState();
}

class InitialAddFriendState extends AddFriendState {
  @override
  List<Object> get props => [];
}

class ValidEmail extends AddFriendState {
  final String message;

  ValidEmail({@required this.message});
  @override
  List<Object> get props => [];
}

class AddFriendEmail extends AddFriendState {
  @override
  List<Object> get props => [];
}

class InvalidEmail extends AddFriendState {
  final String errorMsg;

  InvalidEmail({@required this.errorMsg});

  @override
  List<Object> get props => [];
}

class AddFriendLoading extends AddFriendState {
  @override
  List<Object> get props => [];
}

class AddFriendError extends AddFriendState {
  final String errorMsg;

  AddFriendError({@required this.errorMsg});
  @override
  List<Object> get props => [];
}
