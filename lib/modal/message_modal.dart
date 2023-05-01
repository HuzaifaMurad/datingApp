import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Message extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime dateTime;
  final String timeString;

  Message(
      {required this.id,
      required this.senderId,
      required this.receiverId,
      required this.message,
      required this.dateTime,
      required this.timeString});

  @override
  // TODO: implement propslemented
  List<Object?> get props => [
        id,
        senderId,
        receiverId,
        message,
        dateTime,
        timeString,
      ];
}
