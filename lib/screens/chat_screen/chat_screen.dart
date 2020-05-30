import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_screen_form.dart';
import 'package:chatapp/bloc/emoji_keyboard/bloc.dart';

import 'package:chatapp/bloc/hide_scroll_bar/bloc.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat-screen';
  @override
  Widget build(BuildContext context) {
    final chatData = ModalRoute.of(context).settings.arguments as DocumentSnapshot;
    return MultiBlocProvider(
        providers: [
          BlocProvider<HideScrollBarBloc>(
            create: (_) => HideScrollBarBloc(),
          ),
          BlocProvider<EmojiKeyboardBloc>(
            create: (_) => EmojiKeyboardBloc()..add(HideEmojiKeyboardEvent()),
          )
        ],
        child: ChatScreenForm(
          documentSnapshot: chatData,
        ));
  }
}
