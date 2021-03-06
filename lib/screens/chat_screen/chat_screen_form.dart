import 'dart:ui';

import 'package:chatapp/blocs/chat/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:emoji_picker/emoji_picker.dart';

import 'package:chatapp/blocs/hide_scroll_bar/bloc.dart';
import 'package:chatapp/utilities/single_child_scroll_view_with_scroll_bar.dart';
import 'package:chatapp/widgets/chat_screen/chat.dart';
import 'package:chatapp/blocs/emoji_keyboard/bloc.dart';
import 'package:chatapp/blocs/send_icon/bloc.dart';

class ChatScreenForm extends StatefulWidget {
  static const routeName = '/chat-screen';
  final DocumentSnapshot friendData;
  final List<DocumentSnapshot> messages;
  final String chatId;
  const ChatScreenForm({
    @required this.friendData,
    @required this.messages,
    @required this.chatId,
  });
  @override
  _ChatScreenFormState createState() => _ChatScreenFormState();
}

class _ChatScreenFormState extends State<ChatScreenForm> {
  TextEditingController _messageController;
  ValueKey key = ValueKey('visibility');
  VisibilityDetectorController _visibilityDetectorController;
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _visibilityDetectorController = VisibilityDetectorController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _visibilityDetectorController.forget(key);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final currentState = BlocProvider.of<EmojiKeyboardBloc>(context).state;
        if (currentState is ShownEmojiKeyboardState) {
          print('back button is disabled to close the emoji keyboard');
          BlocProvider.of<EmojiKeyboardBloc>(context).add(HideEmojiKeyboardEvent());
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () => print('another three dots'),
            ),
          ],
          title: Text(widget.friendData['name']),
          centerTitle: true,
        ),
        body: ClipRRect(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          child: Container(
            height: height,
            width: width,
            color: Theme.of(context).accentColor,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Chat(),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  constraints: BoxConstraints(minHeight: 50, maxHeight: 180),
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.tag_faces,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: () {
                            final currentState = BlocProvider.of<EmojiKeyboardBloc>(context).state;

                            /// This is used to dismiss the keyboard to open emoji keyboard.
                            FocusScope.of(context).unfocus();

                            /// This is used to check the current state of the emoji keyboard, if it's
                            /// open then pressing on the icon button will close it and vice versa.
                            if (currentState is ShownEmojiKeyboardState) {
                              BlocProvider.of<EmojiKeyboardBloc>(context)
                                  .add(HideEmojiKeyboardEvent());
                            } else {
                              BlocProvider.of<EmojiKeyboardBloc>(context)
                                  .add(ShowEmojiKeyboardEvent());
                            }
                          }),
                      Expanded(
                          child: VisibilityDetector(
                        key: key,
                        onVisibilityChanged: (info) {
                          if (info.size.height < 180) {
                            BlocProvider.of<HideScrollBarBloc>(context)
                                .add(ShowOrHideScrollBarEvent(isScrollbarShown: false));
                          } else {
                            BlocProvider.of<HideScrollBarBloc>(context)
                                .add(ShowOrHideScrollBarEvent(isScrollbarShown: true));
                          }
                        },
                        child: BlocBuilder<HideScrollBarBloc, HideScrollBarState>(
                            builder: (context, state) {
                          if (state is InitialHideScrollBarState) {
                            return SingleChildScrollViewWithScrollbar(
                              scrollbarThickness: 2,
                              scrollbarColor: state.isScrollbarShown
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  onTap: () {
                                    print('text field is tapped');

                                    /// This condition is used to hide the emoji keyboard once the
                                    /// TextField widget is tapped.
                                    if (!focusNode.hasFocus) {
                                      BlocProvider.of<EmojiKeyboardBloc>(context)
                                          .add(HideEmojiKeyboardEvent());
                                    }
                                  },
                                  onChanged: (msg) {
                                    if (msg.trim().isNotEmpty) {
                                      BlocProvider.of<SendIconBloc>(context)
                                          .add(ColorSwitched(isColorSwitched: true));
                                    } else {
                                      BlocProvider.of<SendIconBloc>(context)
                                          .add(ColorSwitched(isColorSwitched: false));
                                    }
                                  },
                                  focusNode: focusNode,
                                  controller: _messageController,
                                  style: TextStyle(fontSize: 18),
                                  maxLines: null,
                                  minLines: 1,
                                  decoration: InputDecoration.collapsed(
                                    border: InputBorder.none,
                                    hintText: 'Type a message',
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          }
                        }),
                      )),
                      IconButton(
                        icon: BlocBuilder<SendIconBloc, SendIconState>(
                          builder: (context, state) => Icon(
                            Icons.send,
                            color: state is IconColored
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade600,
                          ),
                        ),
                        onPressed: () {
                          final message = _messageController.text;

                          /// When a message is sent, close the keyboard, clear the text field and reset
                          /// the send icon state.
                          if (message.trim().isNotEmpty) {
                            BlocProvider.of<ChatBloc>(context).add(ChatMessageAdded(
                                message: message,
                                chatId: widget.chatId,
                                friendId: widget.friendData['id']));
                            FocusScope.of(context).unfocus();
                            _messageController.clear();
                            BlocProvider.of<SendIconBloc>(context)
                                .add(ColorSwitched(isColorSwitched: false));
                          }
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<EmojiKeyboardBloc, EmojiKeyboardState>(builder: (context, state) {
                  if (state is ShownEmojiKeyboardState) {
                    return EmojiPicker(
                      rows: 3,
                      columns: 7,
                      recommendKeywords: ['laughing'],
                      numRecommended: 10,
                      onEmojiSelected: (emoji, category) {
                        /// This is used to add the emoji to the TextField text.
                        _messageController.text += emoji.emoji;
                      },
                    );
                  } else {
                    return Container(
                      width: 0,
                      height: 0,
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
