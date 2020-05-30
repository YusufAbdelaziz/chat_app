import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AllContactsEvent extends Equatable {
  const AllContactsEvent();
}

class LoadAllContactsEvent extends AllContactsEvent {
  @override
  List<Object> get props => [];
}

class AddMessageEvent extends AllContactsEvent {
  final Map<String, dynamic> chatData;

  AddMessageEvent({@required this.chatData});
  @override
  List<Object> get props => [];
}
