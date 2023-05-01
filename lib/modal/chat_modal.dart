import 'package:equatable/equatable.dart';

import 'modal.dart';

class Chat extends Equatable {
  final String id;
  final String userId;
  final String matchedUserId;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.userId,
    required this.matchedUserId,
    required this.messages,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, matchedUserId, messages];
}
