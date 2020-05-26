import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_screen.dart';
import 'package:chatapp/bloc/emoji_keyboard/bloc.dart';

import 'package:chatapp/bloc/hide_scroll_bar/bloc.dart';

class ChatScreenBlocInitializer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<HideScrollBarBloc>(
        create: (_) => HideScrollBarBloc(),
      ),
      BlocProvider<EmojiKeyboardBloc>(
        create: (_) => EmojiKeyboardBloc()..add(HideEmojiKeyboardEvent()),
      )
    ], child: ChatScreen());
  }
}
