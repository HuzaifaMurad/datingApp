import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:dating_app/modal/modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading());
  @override
  Stream<SwipeState> mapEventToState(
    SwipeEvent event,
  ) async* {
    if (event is LoadedUserEvent) {
      yield* _mapLoadUsersToState(event);
    }
    if (event is SwipeLeftEvent) {
      yield* _mapSwipeLeftToState(event, state);
    }
    if (event is SwipeRightEvent) {
      yield* _mapSwipeRightToState(event, state);
    }
  }

  Stream<SwipeState> _mapLoadUsersToState(LoadedUserEvent event) async* {
    yield SwipeLoaded(users: event.users);
  }

  Stream<SwipeState> _mapSwipeLeftToState(
      SwipeLeftEvent event, SwipeState state) async* {
    if (state is SwipeLoaded) {
      try {
        yield SwipeLoaded(users: List.from(state.users)..remove(event.user));
      } catch (_) {}
    }
  }

  Stream<SwipeState> _mapSwipeRightToState(
      SwipeRightEvent event, SwipeState state) async* {
    if (state is SwipeLoaded) {
      try {
        yield SwipeLoaded(users: List.from(state.users)..remove(event.user));
      } catch (_) {}
    }
  }
}
