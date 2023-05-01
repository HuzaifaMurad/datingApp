import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../modal/modal.dart';

class MessagesModalProvider with ChangeNotifier {
  List<Message> messages = [
    // Message(
    //     id: 1,
    //     senderId: 1,
    //     receiverId: 2,
    //     message: 'Hey, how are you?',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 2,
    //     senderId: 2,
    //     receiverId: 1,
    //     message: 'I\'m good, thank you.',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 3,
    //     senderId: 1,
    //     receiverId: 2,
    //     message: 'I\'m good, as well. Thank you.',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 4,
    //     senderId: 1,
    //     receiverId: 3,
    //     message: 'Hey, how are you?',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 5,
    //     senderId: 3,
    //     receiverId: 1,
    //     message: 'I\'m good, thank you.',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 6,
    //     senderId: 1,
    //     receiverId: 5,
    //     message: 'Hey, how are you?',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 7,
    //     senderId: 5,
    //     receiverId: 1,
    //     message: 'I\'m good, thank you.',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 8,
    //     senderId: 1,
    //     receiverId: 6,
    //     message: 'Hey, how are you?',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 9,
    //     senderId: 6,
    //     receiverId: 1,
    //     message: 'I\'m good, thank you.',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 10,
    //     senderId: 1,
    //     receiverId: 7,
    //     message: 'Hey, how are you?',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 11,
    //     senderId: 7,
    //     receiverId: 1,
    //     message: 'I\'m good, thank you.',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
  ];
  void cleard() {
    messages.clear();
  }

  void sendMessage(String logUser, String matchUser, String message) {
    FirebaseFirestore.instance
        .collection('messages')
        .add({
          'senderId': logUser,
          'receiverId': matchUser,
          'message': message,
          'timeString': DateFormat('jm').format(DateTime.now()),
        })
        .then((value) => log('updated'))
        .catchError((error) => log('error'));
  }

  void reciveAllMesseges(DocumentSnapshot data) {
    messages.add(Message(
        id: data.id,
        senderId: data['senderId'],
        receiverId: data['receiverId'],
        message: data['message'],
        dateTime: DateTime.now(),
        timeString: data['timeString']));
  }
}
