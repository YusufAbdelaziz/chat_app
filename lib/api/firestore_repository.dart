import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:chatapp/api/paths/uri_api.dart';

/// Responsible of connecting between the app and firestore.
class FirestoreRepository {
  final _firestoreInstance = Firestore.instance;

  /// Retrieve user messages.
  Stream<QuerySnapshot> initChats() {
    return _firestoreInstance.collection(collectionPath).snapshots();
  }

  /// Sending messages on firestore.
  void addMessage({@required String message}) {
    Map<String, dynamic> messageMap = {'text': message};
    _firestoreInstance.collection(collectionPath).add(messageMap);
  }

  /// Adding the user to the firestore database.
  Future<void> addFirestoreUser({@required Map<String, dynamic> userData}) async {
    await _firestoreInstance.collection('users').document(userData['userEmail']).setData(userData);
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
