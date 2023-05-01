import 'package:equatable/equatable.dart';

import 'modal.dart';

class UserMatch extends Equatable {
  final String id;
  final String userId;
  final User matchedUser;
  List<Chat>? chat;

  UserMatch(
      {required this.id,
      required this.userId,
      required this.matchedUser,
      required this.chat});

  @override
  List<Object?> get props => [id, userId, matchedUser, chat];
}
