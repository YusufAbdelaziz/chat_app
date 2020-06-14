import 'package:chatapp/bloc/all_contacts/bloc.dart';
import 'package:chatapp/widgets/chat_list/custom_drawer.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/chat_list/contacts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
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
                Icons.search,
                size: 20,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => print('search'),
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
              if (state is LoadedContactsState) {
                return Contacts(
                  chatData: state.chatData,
                );
              } else {
                return Container(
                  height: 0,
                  width: 0,
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
