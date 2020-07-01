import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatapp/utilities/single_child_scroll_view_with_scroll_bar.dart';
import 'bloc.dart';

/// This BLoC is used to hide the scroll bar for [SingleChildScrollViewWithScrollbar] widget as it
/// always shows the scrollbar.
///
class HideScrollBarBloc extends Bloc<HideScrollBarEvent, HideScrollBarState> {
  @override
  HideScrollBarState get initialState => InitialHideScrollBarState(isScrollbarShown: false);

  @override
  Stream<HideScrollBarState> mapEventToState(
    HideScrollBarEvent event,
  ) async* {
    if (event is ShowOrHideScrollBarEvent) {
      yield UnusedHideScrollBarState();
      yield InitialHideScrollBarState(isScrollbarShown: event.isScrollbarShown);
    }
  }
}
