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

class LoadedContactsState extends AllContactsState {
  final QuerySnapshot chatData;

  LoadedContactsState({@required this.chatData});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'LoadedContactsState : {chatData doc num : ${chatData.documents.length}';
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
