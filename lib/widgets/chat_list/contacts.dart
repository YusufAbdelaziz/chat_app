
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'all_contacts.dart';
import 'favorite_contacts.dart';
import 'package:chatapp/blocs/all_chats/all_chats_bloc.dart';
import 'package:chatapp/blocs/all_chats/bloc.dart';
class Contacts extends StatelessWidget {
  final QuerySnapshot contactsData;

  const Contacts({@required this.contactsData});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllChatsBloc, AllChatsState>(
      builder: (context, state) {
        List<DocumentSnapshot> allUsersChats;
        if (state is UpdateAllChats) {
          allUsersChats = state.chats;
        }
        if (allUsersChats == null) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          );
        }
        return Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, top: 15, right: 10, bottom: 15),
              child: Text(
                'Favorite contacts',
                style: Theme.of(context).textTheme.headline4.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            FavoriteContacts(
              contactsData: contactsData,
              allUsersChats: allUsersChats,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: AllContacts(
              contactsData: contactsData,
              allUsersChats: allUsersChats,
            ))
          ],
        );
      },
      listener: (context, state) {
        if (state is LoadAllChatsError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMsg),
            backgroundColor: Theme.of(context).errorColor,
            duration: Duration(minutes: 30),
            action: SnackBarAction(
              label: 'Close',
              textColor: Colors.white,
              onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
            ),
          ));
        }
      },
    );
  }
}
