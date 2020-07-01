import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AllContactsEvent extends Equatable {
  const AllContactsEvent();
}

class AllContactsLoaded extends AllContactsEvent {
  @override
  List<Object> get props => [];
}

class AllContactsUpdated extends AllContactsEvent {
  final QuerySnapshot contact;

  AllContactsUpdated({@required this.contact});
  @override
  List<Object> get props => [];
}

class ContactFavoriteAdded extends AllContactsEvent {
  final String friendId;

  ContactFavoriteAdded({@required this.friendId});
  @override
  List<Object> get props => [];
}

class ContactFavoriteRemoved extends AllContactsEvent {
  final String friendId;

  ContactFavoriteRemoved({@required this.friendId});
  @override
  List<Object> get props => [];
}
