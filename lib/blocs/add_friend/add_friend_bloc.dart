import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:chatapp/api/firestore_repository.dart';
import 'package:chatapp/utilities/validators.dart';

/// Responsible of adding friends to the user and validate that email.
class AddFriendBloc extends Bloc<AddFriendEvent, AddFriendState> {
  final FirestoreRepository firestoreRepository;

  AddFriendBloc({@required this.firestoreRepository});
  @override
  AddFriendState get initialState => InitialAddFriendState();

  @override
  Stream<AddFriendState> mapEventToState(
    AddFriendEvent event,
  ) async* {
    if (event is FriendEmailChecked) {
      if (Validators.isValidEmail(event.peerEmail)) {
        try {
          final result = await firestoreRepository.isPeerEmailExists(peerEmail: event.peerEmail);
          if (result == PeerEmailSearchResult.userFound) {
            yield ValidEmail(message: 'Found the email');
          }
          else if(result == PeerEmailSearchResult.cantAddYourself){
            yield InitialAddFriendState();
            yield InvalidEmail(errorMsg: 'You can\'t add yourself');
          }
          else if(result == PeerEmailSearchResult.userNotFound){
            yield InitialAddFriendState();
            yield InvalidEmail(errorMsg: 'Email is not found.');
          }
        } catch (e, stacktrace) {
          yield InitialAddFriendState();
          yield InvalidEmail(errorMsg: e.toString());
          print(stacktrace);
        }
      } else {
        yield InitialAddFriendState();
        yield InvalidEmail(errorMsg: 'Enter a valid email');
      }
    } else if (event is FriendAdded) {
      try {
        await firestoreRepository.addFriend(peerEmail: event.peerEmail);
        yield AddFriendEmail();
      } catch (e, stacktrace) {
        yield AddFriendError(errorMsg: 'Something went wrong !');
        print(stacktrace);
      }
    }
    else if(event is FriendCheckRestarted){
      yield InitialAddFriendState();
    }
  }

  @override
  Stream<Transition<AddFriendEvent, AddFriendState>> transformEvents(Stream<AddFriendEvent> events,
      TransitionFunction<AddFriendEvent, AddFriendState> transitionFn) {
    return super.transformEvents(events.debounceTime(Duration(milliseconds: 300)), transitionFn);
  }
}
