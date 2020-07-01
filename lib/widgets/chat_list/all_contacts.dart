import 'package:chatapp/widgets/chat_list/users_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/api/firestore_repository.dart';
import 'package:chatapp/blocs/chat/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllContacts extends StatelessWidget {
  final QuerySnapshot contactsData;
  final List<DocumentSnapshot> allUsersChats;
  const AllContacts({@required this.contactsData, @required this.allUsersChats});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final friends = contactsData.documents;
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      child: Container(
        color: Theme.of(context).accentColor,
        width: width,
        child: friends.length == 0
            ? Center(
                child: Text('Add some friends using the plus icon',
                    style: Theme.of(context).textTheme.headline2))
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  /// Getting the correct friend chat for specific index among the friends list.
                  final friendChat = allUsersChats.firstWhere((chat) {
                    return chat.documentID.contains(friends[index]['id']);
                  }, orElse: () => null);
                  if (friendChat == null) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      ),
                    );
                  }
                  /// A friend chat is passed to the [ChatBloc] to listen to this specific chat changes.
                  return BlocProvider<ChatBloc>(
                    create: (context) => ChatBloc(
                        friendChat: friendChat,
                        firestoreRepo: RepositoryProvider.of<FirestoreRepository>(context))
                      ..add(ChatLoaded()),
                    child: Builder(
                      builder: (context) =>
                          BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
                        List<DocumentSnapshot> messages;
                        if (state is UpdateChat) {
                          messages = state.chat.documents;
                        }
                        if (messages == null) {
                          return Container(
                            width: 0,
                            height: 0,
                          );
                        }

                        /// Since the messages list is reversed, the last message is at first index
                        /// of the list.
                        String lastMessage;
                        Timestamp lastMessageDate;
                        if (messages.length != 0) {
                          lastMessage = messages[0]['text'];
                          lastMessageDate = messages[0]['timeStamp'];
                        }

                        return UsersCard(
                          lastMessage: lastMessage,
                          key: ValueKey(friendChat.documentID),
                          lastMessageDate: lastMessageDate,
                          messages: messages,
                          friend: friends[index],
                          chatId: friendChat?.documentID,
                        );
                      }),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
