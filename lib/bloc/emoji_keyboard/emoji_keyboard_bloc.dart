import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class EmojiKeyboardBloc extends Bloc<EmojiKeyboardEvent, EmojiKeyboardState> {
  @override
  EmojiKeyboardState get initialState => InitialShowEmojiKeyboardState();

  @override
  Stream<EmojiKeyboardState> mapEventToState(
    EmojiKeyboardEvent event,
  ) async* {
    if (event is ShowEmojiKeyboardEvent) {
      yield ShownEmojiKeyboardState();
    }
    else if(event is HideEmojiKeyboardEvent)
      {
        yield HiddenEmojiKeyboardState();
      }
  }
}
