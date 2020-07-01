import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_screen_form.dart';
import 'package:chatapp/blocs/emoji_keyboard/bloc.dart';
import 'package:chatapp/blocs/hide_scroll_bar/bloc.dart';
import 'package:chatapp/blocs/send_icon/send_icon_bloc.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat-screen';
  final DocumentSnapshot friendData;
  final List<DocumentSnapshot> messages;
  final String chatId;

  const ChatScreen({@required this.friendData, @required this.messages, @required this.chatId});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HideScrollBarBloc>(
            create: (_) => HideScrollBarBloc(),
          ),
          BlocProvider<EmojiKeyboardBloc>(
            create: (_) => EmojiKeyboardBloc()..add(HideEmojiKeyboardEvent()),
          ),
          BlocProvider<SendIconBloc>(
            create: (_) => SendIconBloc(),
          )
        ],
        child: ChatScreenForm(
          friendData: friendData,
          messages: messages,
          chatId: chatId,
        ));
  }
}
