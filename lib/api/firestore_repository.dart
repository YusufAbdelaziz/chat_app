import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:chatapp/api/user_repository.dart';

enum PeerEmailSearchResult { cantAddYourself, userFound, userNotFound }

/// Responsible of the connection between the app and firestore.
class FirestoreRepository {
  final _firestoreInstance = Firestore.instance;
  final _userRepo = UserRepository.getInstance();

  /// Retrieve user's friends from firestore.
  Stream<QuerySnapshot> initContacts() {
    return _firestoreInstance.collection('users/${_userRepo.userId}/friends').snapshots();
  }

  /// Checks if the email that user entered exists on firestore database or not.
  Future<PeerEmailSearchResult> isPeerEmailExists({@required String peerEmail}) async {
    if (peerEmail != _userRepo.userEmail) {
      final querySnapShot = await _firestoreInstance.collection('users').getDocuments();
      final doc = querySnapShot.documents
          .firstWhere((peerUser) => peerUser['userEmail'] == peerEmail, orElse: () => null);

      if (doc == null) {
        return PeerEmailSearchResult.userNotFound;
      } else {
        return PeerEmailSearchResult.userFound;
      }
    } else {
      return PeerEmailSearchResult.cantAddYourself;
    }
  }

  Future<DocumentSnapshot> _getPeerEmail({@required peerEmail}) async {
    final querySnapShot = await _firestoreInstance.collection('users').getDocuments();
    final doc = querySnapShot.documents
        .firstWhere((peerUser) => peerUser['userEmail'] == peerEmail, orElse: null);
    return doc;
  }

  /// Adding friends to a user on firestore.
  Future<void> addFriend({@required String peerEmail}) async {
    final friend = await _getPeerEmail(peerEmail: peerEmail);

    Map<String, dynamic> friendData = {
      'id': friend['id'],
      'imageUrl': friend['imageUrl'],
      'name': friend['name'],
      'userEmail': friend['userEmail'],
      'isFavourite': false
    };

    Map<String, dynamic> userInfo = _userRepo.getFirestoreUserData();

    /// You have to add yourself to your friend's 'friends' collection and add your friend to your
    /// 'friends' collection.
    await _firestoreInstance
        .collection('users/${_userRepo.userId}/friends')
        .document(friendData['id'])
        .setData(friendData);
    await _firestoreInstance
        .collection('users/${friend['id']}/friends')
        .document(userInfo['id'])
        .setData(userInfo);

    /// Any field must be added to the chat document to instantiate the document and be able to make queries.
    await _firestoreInstance
        .collection('chat')
        .document('${_userRepo.userId + friend['id']}')
        .setData({'works': true});
  }

  /// Adding the user to the firestore database.
  Future<void> addFirestoreUser({@required Map<String, dynamic> userData}) async {
    await _firestoreInstance.collection('users').document(userData['id']).setData(userData);
  }

  Stream<QuerySnapshot> getChats() {
    return _firestoreInstance.collection('chat').snapshots();
  }

  List<DocumentSnapshot> filterUserChats({@required QuerySnapshot chats}) {
    return chats.documents.where((doc) => doc.documentID.contains(_userRepo.userId)).toList();
  }

  Stream<QuerySnapshot> listenToChat({@required DocumentSnapshot documentSnapshot}) {
    return documentSnapshot.reference
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }

  Future<void> addMessage(
      {@required String chatId, @required String message, @required String friendId}) async {
    Map<String, dynamic> messageMap = {
      'text': message,
      'timeStamp': Timestamp.now(),
      'userId': _userRepo.userId
    };
    print('chat id --> $chatId');
    await _firestoreInstance.collection('chat/$chatId/messages').add(messageMap);
  }

  Future<void> addFavoriteContact({@required String friendId}) async {
    await _firestoreInstance
        .collection('users/${_userRepo.userId}/friends')
        .document(friendId)
        .updateData({'isFavourite': true});
  }

  Future<void> removeFavouriteContact({@required String friendId}) async {
    await _firestoreInstance
        .collection('users/${_userRepo.userId}/friends')
        .document(friendId)
        .updateData({'isFavourite': false});
  }

  static FirestoreRepository _firestoreRepository;
  FirestoreRepository._();
  static FirestoreRepository getInstance() {
    if (_firestoreRepository == null) {
      _firestoreRepository = FirestoreRepository._();
    }
    return _firestoreRepository;
  }
}
