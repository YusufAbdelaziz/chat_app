import 'package:chatapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Message extends StatelessWidget {
  final DocumentSnapshot message;

  const Message({@required this.message});
  @override
  Widget build(BuildContext context) {
    final timeStamp = message['timeStamp'] as Timestamp;
    final isMyAccount = message['userId'] == User.getInstance().id;
    return Container(
      /// The key is added so nothing goes wrong when updating the chat.
      key: ValueKey(message.documentID),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      constraints: BoxConstraints(maxWidth: 150, minWidth: 100),
      margin: isMyAccount ? EdgeInsets.only(left: 200) : EdgeInsets.only(right: 200),
      decoration: BoxDecoration(
          borderRadius: isMyAccount
              ? BorderRadius.horizontal(left: Radius.circular(25))
              : BorderRadius.horizontal(right: Radius.circular(25)),
          color: isMyAccount
              ? Theme.of(context).primaryColor.withOpacity(0.5)
              : Theme.of(context).canvasColor),
      child: Column(
        crossAxisAlignment: isMyAccount ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          Text(DateFormat.jm().format(timeStamp.toDate()),
              style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 12)),
          SizedBox(
            height: 10,
          ),
          Text(message['text'],
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
