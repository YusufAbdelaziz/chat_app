import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/api/firestore_repository.dart';
import 'package:chatapp/blocs/add_friend/bloc.dart';
import 'package:chatapp/screens/chat_list_screen/chat_list_screen_form.dart';
import 'package:chatapp/blocs/all_chats/bloc.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddFriendBloc>(
          create: (context) => AddFriendBloc(
              firestoreRepository: RepositoryProvider.of<FirestoreRepository>(context)),
        ),
        BlocProvider<AllChatsBloc>(
          create: (context) =>
              AllChatsBloc(firestoreRepo: RepositoryProvider.of<FirestoreRepository>(context))
                ..add(AllChatsLoaded()),
        )
      ],
      child: ChatListScreenForm(),
    );
  }
}
