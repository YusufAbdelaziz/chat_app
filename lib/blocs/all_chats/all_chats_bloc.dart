import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

import 'package:chatapp/api/firestore_repository.dart';

class   AllChatsBloc extends Bloc<AllChatsEvent, AllChatsState> {
  final FirestoreRepository firestoreRepo;
  StreamSubscription _streamSubscription;

  AllChatsBloc({@required this.firestoreRepo});

  @override
  AllChatsState get initialState => InitialAllChatState();

  @override
  Stream<AllChatsState> mapEventToState(
    AllChatsEvent event,
  ) async* {
    if (event is AllChatsLoaded) {
      yield* _mapChatsToState();
    } else if (event is AllChatsUpdated) {
      yield* _mapUpdateChatsToState(chatList: event.chats);
    }
  }

  Stream<AllChatsState> _mapChatsToState() async* {
    _streamSubscription?.cancel();
    _streamSubscription = firestoreRepo.getChats().listen((chats) {
      add(AllChatsUpdated(chats: firestoreRepo.filterUserChats(chats: chats)));
    });
  }

  Stream<AllChatsState> _mapUpdateChatsToState({@required List<DocumentSnapshot> chatList}) async* {
    yield InitialAllChatState();
    yield UpdateAllChats(chats: chatList);
  }
}
