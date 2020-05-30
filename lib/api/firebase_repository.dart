import 'package:chatapp/api/paths/api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseRepository {
  final chatCollection = Firestore.instance.collection(collectionPath);

  /// This is typically used to get messages on firestore.
  Stream<QuerySnapshot> initChats() {
    return chatCollection.snapshots();
  }

  /// This is used to send messages on firestore.
  void addMessage({@required String message}) {
    Map<String, dynamic> messageMap = {'text': message};
    chatCollection.add(messageMap);
  }
}
