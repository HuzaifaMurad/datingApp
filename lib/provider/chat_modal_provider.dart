import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../modal/modal.dart';

class ChatModalProvider with ChangeNotifier {
  List<Message> messages = [];
  ChatModalProvider(this.messages);
  List<Chat> chats = [];

  List<Chat> get chattingChats {
    // chats = [
    //   Chat(
    //     id: 1,
    //     userId: 1,
    //     matchedUserId: 2,
    //     messages: messages
    //         .where((message) =>
    //             (message.senderId == 1 && message.receiverId == 2) ||
    //             (message.senderId == 2 && message.receiverId == 1))
    //         .toList(),
    //   ),
    //   Chat(
    //     id: 2,
    //     userId: 1,
    //     matchedUserId: 3,
    //     messages: messages
    //         .where((message) =>
    //             (message.senderId == 1 && message.receiverId == 3) ||
    //             (message.senderId == 3 && message.receiverId == 1))
    //         .toList(),
    //   ),
    //   Chat(
    //     id: 3,
    //     userId: 1,
    //     matchedUserId: 5,
    //     messages: messages
    //         .where((message) =>
    //             (message.senderId == 1 && message.receiverId == 5) ||
    //             (message.senderId == 5 && message.receiverId == 1))
    //         .toList(),
    //   ),
    //   Chat(
    //     id: 4,
    //     userId: 1,
    //     matchedUserId: 6,
    //     messages: messages
    //         .where((message) =>
    //             (message.senderId == 1 && message.receiverId == 6) ||
    //             (message.senderId == 6 && message.receiverId == 1))
    //         .toList(),
    //   ),
    // ];

    return chats;
  }

  void addNewChat(String userId, String matchId) {
    chats.insert(
        0,
        Chat(
            id: DateTime.now().toString(),
            userId: userId,
            matchedUserId: matchId,
            messages: messages
                .where((message) =>
                    (message.senderId == userId &&
                        message.receiverId == matchId) ||
                    (message.senderId == matchId &&
                        message.receiverId == userId))
                .toList()));
  }
}
