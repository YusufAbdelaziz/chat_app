import 'package:equatable/equatable.dart';

abstract class EmojiKeyboardState extends Equatable {
  const EmojiKeyboardState();
}

class InitialShowEmojiKeyboardState extends EmojiKeyboardState {
  @override
  List<Object> get props => [];
}

class ShownEmojiKeyboardState extends EmojiKeyboardState {
  @override
  List<Object> get props => [];
}

class HiddenEmojiKeyboardState extends EmojiKeyboardState {
  @override
  List<Object> get props => [];
}
