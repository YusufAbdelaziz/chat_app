import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AllChatsState extends Equatable {
  const AllChatsState();
}

class InitialAllChatState extends AllChatsState {
  @override
  List<Object> get props => [];
}

class UpdateAllChats extends AllChatsState {
  final List<DocumentSnapshot> chats;

  UpdateAllChats({@required this.chats});
  @override
  String toString() {
    return 'UpdateAllChats : {chats num : ${chats.length}';
  }

  @override
  List<Object> get props => [];
}

class LoadAllChatsError extends AllChatsState {
  final String errorMsg;

  LoadAllChatsError({@required this.errorMsg});

  @override
  List<Object> get props => [];
}
