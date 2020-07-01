import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatLoaded extends ChatEvent {
  @override
  List<Object> get props => [];
}

class ChatUpdated extends ChatEvent {
  final QuerySnapshot chat;

  ChatUpdated({@required this.chat});

  @override
  String toString() {
    return 'ChatUpdated : { chat num : ${chat.documents.length}';
  }

  @override
  List<Object> get props => [];
}

class ChatMessageAdded extends ChatEvent {
  final String message;
  final String chatId;
final String friendId;
  ChatMessageAdded({@required this.message, @required this.chatId,@required this.friendId});

  @override
  List<Object> get props => [];
}
