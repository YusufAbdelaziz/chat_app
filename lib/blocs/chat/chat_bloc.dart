import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chatapp/api/firestore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final DocumentSnapshot friendChat;
  final FirestoreRepository firestoreRepo;
  ChatBloc({@required this.friendChat, @required this.firestoreRepo});
  @override
  ChatState get initialState => InitialChatState();

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is ChatLoaded) {
      yield* _mapChatLoadToState();
    } else if (event is ChatUpdated) {
      yield* _mapChatUpdatedToState(chat: event.chat);
    } else if (event is ChatMessageAdded) {
      yield* _mapChatMessageAddedToState(
          chatId: event.chatId, message: event.message, friendId: event.friendId);
    }
  }

  Stream<ChatState> _mapChatLoadToState() async* {
    firestoreRepo.listenToChat(documentSnapshot: friendChat).listen((chat) {
      add(ChatUpdated(chat: chat));
    });
  }

  Stream<ChatState> _mapChatUpdatedToState({@required QuerySnapshot chat}) async* {
    yield InitialChatState();
    yield UpdateChat(chat: chat);
  }

  Stream<ChatState> _mapChatMessageAddedToState(
      {@required String chatId, @required String message, @required String friendId}) async* {
    firestoreRepo.addMessage(chatId: chatId, message: message, friendId: friendId);
  }
}
