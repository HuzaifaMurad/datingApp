// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:dating_app/modal/modal.dart';
import 'package:dating_app/provider/AuthServices.dart';
import 'package:dating_app/provider/messageModal_provider.dart';
import 'package:dating_app/provider/user_match_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat-screen';
  final UserMatch userMatch;

  const ChatScreen({Key? key, required this.userMatch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    // final userMatch = ModalRoute.of(context)!.settings.arguments as UserMatch;
    // var idx = ModalRoute.of(context)!.settings.arguments as int;

    final send = Provider.of<MessagesModalProvider>(context);
    final auth = Provider.of<AuthServies>(context);

    // final usr = Provider.of<UserMatcheProvider>(context);
    // var userMatch = usr.matchedUser[idx];

    String? message;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 17,
                backgroundImage:
                    NetworkImage(userMatch.matchedUser.imageUrls![0]),
              ),
            ),
            Text(
              userMatch.matchedUser.name!,
              style: GoogleFonts.lato(fontSize: 13, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: userMatch.chat == null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 150.0),
                      child: Text('Lets Start Conversation...'),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title: userMatch.chat![0].messages[index].senderId ==
                                auth.userUid
                            ? Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            Theme.of(context).backgroundColor),
                                    child: Text(userMatch
                                        .chat![0].messages[index].message)),
                              )
                            : Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 17,
                                      backgroundImage: NetworkImage(
                                          userMatch.matchedUser.imageUrls![0]),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Text(
                                        userMatch
                                            .chat![0].messages[index].message,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      shrinkWrap: true,
                      itemCount: userMatch.chat![0].messages.length,
                    ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: IconButton(
                    ///////
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      send.sendMessage(
                        auth.userUid!,
                        userMatch.id,
                        message!,
                      );

                      print('sending messages');
                      messageController.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      hintText: 'type here..',
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.only(left: 20, bottom: 5, top: 5),
                    ),
                    controller: messageController,
                    onChanged: (value) {
                      message = value;
                      print(value);
                    },
                    onSubmitted: (value) {
                      send.sendMessage(
                        auth.userUid!,
                        userMatch.id,
                        message!,
                      );

                      log(userMatch.id);
                      print('sending messages');
                      messageController.clear();
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
