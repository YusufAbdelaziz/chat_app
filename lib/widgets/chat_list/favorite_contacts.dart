import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/api/firestore_repository.dart';
import 'package:chatapp/blocs/all_contacts/all_contacts_bloc.dart';
import 'package:chatapp/blocs/all_contacts/bloc.dart';
import 'package:chatapp/blocs/chat/bloc.dart';
import 'package:chatapp/blocs/chat/chat_bloc.dart';
import 'package:chatapp/screens/chat_screen/chat_screen.dart';

class FavoriteContacts extends StatelessWidget {
  final QuerySnapshot contactsData;
  final List<DocumentSnapshot> allUsersChats;
  const FavoriteContacts({@required this.contactsData, @required this.allUsersChats});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    /// Filtering the favourite users only.
    final favouriteContacts =
        contactsData.documents.where((contact) => contact['isFavourite'] == true).toList();
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 90,
      child: favouriteContacts.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (__, _) => SizedBox(
                    width: 20,
                  ),
              shrinkWrap: true,
              itemCount: favouriteContacts.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                /// Searching for the correct favourite user chat between all users chats that belongs
                /// to the user.
                final favouriteContactChat = allUsersChats.firstWhere((chat) {
                  return chat.documentID.contains(favouriteContacts[index]['id']);
                }, orElse: () => null);
                if (favouriteContactChat == null) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),
                  );
                }
                return BlocProvider<ChatBloc>(
                  create: (context) => ChatBloc(
                      friendChat: favouriteContactChat,
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
                      return InkWell(
                        splashColor: Colors.transparent,
                        onLongPress: () {
                          final position = buttonMenuPosition(context);
                          showMenu(context: context, position: position, items: [
                            PopupMenuItem<int>(
                              child: FlatButton(
                                child: Text(
                                  'Remove from favourites',
                                  style:
                                      Theme.of(context).textTheme.headline2.copyWith(fontSize: 14),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(0);
                                },
                              ),
                            )
                          ]).then((value) async {
                            if (value == 0) {
                              BlocProvider.of<AllContactsBloc>(context).add(
                                  ContactFavoriteRemoved(friendId: favouriteContacts[index]['id']));
                            }
                          });
                        },
                        hoverColor: Colors.transparent,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<ChatBloc>(context),
                            child: ChatScreen(
                              messages: messages,
                              chatId: favouriteContactChat?.documentID,
                              friendData: favouriteContacts[index],
                            ),
                          );
                        })),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/user.png',
                                    fit: BoxFit.cover,
                                    image: favouriteContacts[index]['imageUrl']),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            AutoSizeText(
                              favouriteContacts[index]['name'],
                              minFontSize: 12,
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                );
              })
          : Center(
              child: Text(
              'No favourite contacts found, long tap to add your contacts to favourite list !',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 16),
            )),
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
