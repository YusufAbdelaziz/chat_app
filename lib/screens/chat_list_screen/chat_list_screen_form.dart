import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/blocs/all_contacts/bloc.dart';
import 'package:chatapp/widgets/chat_list/contacts.dart';
import 'package:chatapp/widgets/chat_list/custom_drawer.dart';
import 'package:chatapp/blocs/add_friend/bloc.dart';
import 'package:chatapp/widgets/chat_list/custom_alert_dialog.dart';

class ChatListScreenForm extends StatefulWidget {
  @override
  _ChatListScreenFormState createState() => _ChatListScreenFormState();
}

class _ChatListScreenFormState extends State<ChatListScreenForm> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          actions: <Widget>[
            IconButton(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              icon: Icon(
                Icons.add,
                size: 24,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return BlocProvider.value(
                          value: BlocProvider.of<AddFriendBloc>(context),
                          child: CustomAlertDialog());
                    }).then((value) =>

                    /// Reset the bloc state to initial state so you can re-check the peer email in case
                    /// you want to add another one.
                    BlocProvider.of<AddFriendBloc>(context).add(FriendCheckRestarted()));
              },
            )
          ],
        ),
        drawer: CustomDrawer(),
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: BlocConsumer<AllContactsBloc, AllContactsState>(
            builder: (context, state) {
              QuerySnapshot contactsData;
              if (state is UpdateContacts) {
                contactsData = state.contacts;
              }
              if (contactsData == null) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                );
              } else {
                return Contacts(
                  contactsData: contactsData,
                );
              }
            },
            listener: (context, state) {
              if (state is ErrorContactsState) {
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
          ),
        ));
  }
}
