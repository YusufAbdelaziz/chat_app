import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class InitialChatState extends ChatState {
  @override
  List<Object> get props => [];
}

class UpdateChat extends ChatState {
  final QuerySnapshot chat;

  UpdateChat({@required this.chat});
  @override
  String toString() {
    return 'UpdateChat : { chat num : ${chat.documents.length}';
  }

  @override
  List<Object> get props => [];
}
