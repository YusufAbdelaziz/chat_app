import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AllChatsEvent extends Equatable {
  const AllChatsEvent();
}

class AllChatsLoaded extends AllChatsEvent {
  @override
  List<Object> get props => [];
}

class AllChatsUpdated extends AllChatsEvent {
  final List<DocumentSnapshot> chats;

  String toString() {
    return 'AllChatsUpdated : {chats num : ${chats.length}';
  }

  AllChatsUpdated({@required this.chats});
  @override
  List<Object> get props => [];
}
