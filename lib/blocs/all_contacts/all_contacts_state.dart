import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AllContactsState extends Equatable {
  const AllContactsState();
}

class InitialAllContactsState extends AllContactsState {
  @override
  List<Object> get props => [];
}

class LoadChatsState extends AllContactsState {
  final QuerySnapshot contacts;

  LoadChatsState({@required this.contacts});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'LoadedContactsState : {chatData doc num : ${contacts.documents.length}';
}

class UpdateContacts extends AllContactsState {
  final QuerySnapshot contacts;

  UpdateContacts({@required this.contacts});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'UpdateContacts : {contacts doc num : ${contacts.documents.length}';
}

class ErrorContactsState extends AllContactsState {
  final String errorMsg;

  ErrorContactsState({@required this.errorMsg});

  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}
