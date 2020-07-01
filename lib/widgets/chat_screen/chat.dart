import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/chat_screen/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/blocs/chat/bloc.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        List<DocumentSnapshot> messages;
        if (state is UpdateChat) {
          messages = state.chat.documents;
        }
        if (messages.length == 0) {
          return Center(
              child: Text('Start chatting with your friend!',
                  style: Theme.of(context).textTheme.headline2));
        }
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (_, __) => SizedBox(height: 15),
            reverse: true,
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: messages.length,
            itemBuilder: (context, index) => Message(message: messages[index]));
      },
    );
  }
}
