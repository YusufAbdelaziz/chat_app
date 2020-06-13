import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chatapp/api/firestore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

/// This bloc is used to load the chats you have.
class AllContactsBloc extends Bloc<AllContactsEvent, AllContactsState> {
  final FirestoreRepository firebaseRepository;
  StreamController<QuerySnapshot> messagesController;

  AllContactsBloc({@required this.firebaseRepository}) {
    var messagesSnapshots = firebaseRepository.initChats();
    messagesController = StreamController<QuerySnapshot>.broadcast()..addStream(messagesSnapshots);
  }

  @override
  AllContactsState get initialState => InitialAllContactsState();

  @override
  Stream<AllContactsState> mapEventToState(
    AllContactsEvent event,
  ) async* {
    if (event is LoadAllContactsEvent) {
      yield* _mapChatsToState(messagesController);
    }
  }

  Stream<AllContactsState> _mapChatsToState(
    StreamController<QuerySnapshot> messagesController,
  ) async* {
    await for (QuerySnapshot data in messagesController.stream) {
      yield InitialAllContactsState();
      yield LoadedContactsState(chatData: data);
    }
  }

  void disposeMessageController() {
    messagesController.close();
  }
}
