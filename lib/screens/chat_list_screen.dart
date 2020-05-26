import 'package:flutter/material.dart';

import 'package:chatapp/widgets/chat_list/contacts.dart';

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final space = SizedBox(
      width: 30,
    );
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
        drawer: Drawer(
          child: Text('Hola'),
        ),
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Contacts(),
        ));
  }
}
