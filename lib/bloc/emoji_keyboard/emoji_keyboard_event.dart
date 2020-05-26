import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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