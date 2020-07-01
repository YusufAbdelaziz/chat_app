import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

import 'package:chatapp/api/firestore_repository.dart';

/// This bloc is used to load the contacts you have added.
class AllContactsBloc extends Bloc<AllContactsEvent, AllContactsState> {
  final FirestoreRepository firestoreRepo;
  StreamSubscription _streamSubscription;

  AllContactsBloc({@required this.firestoreRepo});

  @override
  AllContactsState get initialState => InitialAllContactsState();

  @override
  Stream<AllContactsState> mapEventToState(
    AllContactsEvent event,
  ) async* {
    if (event is AllContactsLoaded) {
      yield* _mapContactsToState();
    } else if (event is AllContactsUpdated) {
      yield* _mapContactsUpdateToState(contactsList: event.contact);
    } else if (event is ContactFavoriteAdded) {
      yield* _mapContactFavouriteAddToState(friendId: event.friendId);
    } else if (event is ContactFavoriteRemoved) {
      yield* _mapContactFavouriteRemoveToState(friendId: event.friendId);
    }
  }

  /// Listens to the contact status changes.
  Stream<AllContactsState> _mapContactsToState() async* {
    _streamSubscription?.cancel();
    _streamSubscription = firestoreRepo.initContacts().listen((contact) {
      add(AllContactsUpdated(contact: contact));
    }, onError: (error) {
      print('An error occurred in all contacts bloc');
    });
  }

  Stream<AllContactsState> _mapContactsUpdateToState(
      {@required QuerySnapshot contactsList}) async* {
    yield InitialAllContactsState();
    yield UpdateContacts(contacts: contactsList);
  }

  Stream<AllContactsState> _mapContactFavouriteAddToState({@required String friendId}) async* {
    await firestoreRepo.addFavoriteContact(friendId: friendId);
  }

  Stream<AllContactsState> _mapContactFavouriteRemoveToState({@required String friendId}) async* {
    await firestoreRepo.removeFavouriteContact(friendId: friendId);
  }
}
