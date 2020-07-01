import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:chatapp/blocs/all_contacts/all_contacts_bloc.dart';
import 'package:chatapp/blocs/all_contacts/all_contacts_event.dart';
import 'package:chatapp/blocs/chat/chat_bloc.dart';
import 'package:chatapp/screens/chat_screen/chat_screen.dart';
import '../../utilities/date_time_extension.dart';

class UsersCard extends StatelessWidget {
  final List<DocumentSnapshot> messages;
  final DocumentSnapshot friend;
  final String chatId;
  final String lastMessage;
  final Timestamp lastMessageDate;

  const UsersCard(
      {Key key,
      @required this.messages,
      @required this.friend,
      @required this.chatId,
      @required this.lastMessage,
      @required this.lastMessageDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: ListTile(
        onLongPress: () {
          final position = buttonMenuPosition(context);
          showMenu(context: context, position: position, items: [
            PopupMenuItem<int>(
              child: FlatButton(
                child: Text(
                  'Add to favorites',
                  style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 14),
                ),
                onPressed: () {
                  Navigator.of(context).pop(0);
                },
              ),
            )
          ]).then((value) async {
            if (value == 0) {
              BlocProvider.of<AllContactsBloc>(context)
                  .add(ContactFavoriteAdded(friendId: friend['id']));
            }
          });
        },
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<ChatBloc>(context),
            child: ChatScreen(
              messages: messages,
              chatId: chatId,
              friendData: friend,
            ),
          );
        })),
        leading: CircleAvatar(
          radius: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/user.png',
                fit: BoxFit.cover,
                image: friend['imageUrl']),
          ),
        ),
        title: Text(
          friend['name'] ?? '',
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          lastMessage ?? '',
          style: Theme.of(context).textTheme.headline5,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              lastMessageDate == null
                  ? ''
                  : () {
                      /// This anonymous method is used to change how the date of last message appear.
                      DateTime lastMessageDateTime = lastMessageDate.toDate();
                      if (DateTimeExtension.isToday(date: lastMessageDateTime)) {
                        return DateFormat.jm().format(lastMessageDateTime);
                      } else if (DateTimeExtension.isYesterday(date: lastMessageDateTime)) {
                        return 'Yesterday';
                      } else {
                        return DateFormat('dd/MM/yy').format(lastMessageDate.toDate());
                      }
                    }(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),

            /// You can make a conditions here in case you want to add a feature in which a message
            /// is seen or not.
//            Container(
//              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 3),
//              decoration: BoxDecoration(
//                  color: Theme.of(context).primaryColor,
//                  borderRadius: BorderRadius.all(Radius.circular(15))),
//              child: Text(
//                'New',
//                style: TextStyle(
//                    color: Theme.of(context).accentColor,
//                    fontSize: 12,
//                    fontWeight: FontWeight.bold),
//              ),
//            )
          ],
        ),
      ),
    );
  }

  RelativeRect buttonMenuPosition(BuildContext c) {
    final RenderBox bar = c.findRenderObject();
    final RenderBox overlay = Overlay.of(c).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        bar.localToGlobal(bar.size.center(Offset.zero), ancestor: overlay),
        bar.localToGlobal(bar.size.center(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    return position;
  }
}
