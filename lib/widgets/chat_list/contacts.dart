import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'all_contacts.dart';
import 'favorite_contacts.dart';

class Contacts extends StatelessWidget {
  final QuerySnapshot chatData;

  const Contacts({@required this.chatData});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 15, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Favorite contacts',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.55)),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.black.withOpacity(0.55),
                ),
                onPressed: () => print('hola'),
              )
            ],
          ),
        ),
        FavoriteContacts(),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: AllContacts(
          chatData: chatData,
        ))
      ],
    );
  }
}
