import 'package:equatable/equatable.dart';

abstract class EmojiKeyboardEvent extends Equatable {
  const EmojiKeyboardEvent();
}

class ShowEmojiKeyboardEvent extends EmojiKeyboardEvent {


  @override
  List<Object> get props => [];
}

class HideEmojiKeyboardEvent extends EmojiKeyboardEvent {


  @override
  List<Object> get props => [];
}