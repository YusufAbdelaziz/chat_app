import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AddFriendEvent extends Equatable {
  const AddFriendEvent();
}

class FriendEmailChecked extends AddFriendEvent {
  final String peerEmail;

  FriendEmailChecked({@required this.peerEmail});
  @override
  String toString() {
    return 'FriendEmailChecked : {peerEmail : $peerEmail}';
  }

  @override
  List<Object> get props => [];
}

class FriendAdded extends AddFriendEvent {
  final String peerEmail;

  FriendAdded({@required this.peerEmail});
  @override
  String toString() {
    return 'FriendAdded : {peerEmail : $peerEmail}';
  }

  @override
  List<Object> get props => [];
}

class FriendCheckRestarted extends AddFriendEvent {
  @override
  List<Object> get props => [];
}
