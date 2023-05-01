// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/modal/user_match_modal.dart';
import 'package:dating_app/provider/AuthServices.dart';
import 'package:dating_app/provider/messageModal_provider.dart';
import 'package:dating_app/screen/chat_screen.dart';
import 'package:dating_app/widgets/customAppbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/chat_modal_provider.dart';
import '../provider/user_match_provider.dart';

class MatchesScreen extends StatefulWidget {
  static const routeName = '/matches-scren';
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  @override
  Widget build(BuildContext context) {
    final matches = Provider.of<UserMatcheProvider>(context);
    final auth = Provider.of<AuthServies>(context);
    final cht = Provider.of<ChatModalProvider>(context);
    final msg = Provider.of<MessagesModalProvider>(context);
    bool chatScreen = true;
    bool inactive = true;
    int? indexs;
    UserMatch? userMatch;

    // void getMatchesFromFirebase()async {
    //  await matches.fetchMatchData(auth.userUid!);
    // }

    // final inActiveMatches = matches.userMatched
    //     .where(
    //       (match) => match.userId == '1' && match.chat!.isEmpty,
    //     )
    //     .toList();
    // final activeMatches = matches.matchedUser
    //     .where(
    //       (match) => match.userId == '1' && match.chat!.isNotEmpty,
    //     )
    //     .toList();

    return Scaffold(
      appBar: CustomAppBar(title: 'Matches'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('messages').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatsDoc = snapshot.data!.docs;
              msg.cleard();
              for (var chat in chatsDoc) {
                msg.reciveAllMesseges(chat);
              }
              for (var val in msg.messages) {
                log(val.message);
              }

              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(auth.userUid)
                    .collection('matches')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final userDoc = snapshot.data!.docs;
                  matches.matchedUser = [];
                  for (var usr in userDoc) {
                    matches.fetchMatchData(usr, auth.userUid!);
                  }

                  cht.chats = [];
                  for (var match in matches.matchedUser) {
                    cht.addNewChat(auth.userUid!, match.id);
                    match.chat = cht.chats
                        .where((chat) =>
                            chat.userId == auth.userUid ||
                            chat.matchedUserId == match.id)
                        .toList();
                  }
                  int i = 0;
                  log(matches.matchedUser.length.toString());

                  final inActiveMatches = matches.matchedUser
                      .where(
                        (match) =>
                            match.userId == auth.userUid &&
                            match.chat![0].messages.isEmpty,
                      )
                      .toList();

                  // log('inactive matches are $inActiveMatches');
                  final activeMatches = matches.matchedUser
                      .where(
                        (match) =>
                            match.userId == auth.userUid &&
                            match.chat![0].messages.isNotEmpty,
                      )
                      .toList();

                  if (chatScreen == false) {
                    Timer(
                      Duration(milliseconds: 100),
                      () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              ChatScreen(userMatch: activeMatches[indexs!]),
                        ));
                      },
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Like',
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: inActiveMatches.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    inactive = false;
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                          userMatch: inActiveMatches[index]),
                                    ));
                                  },
                                  child: UserImageSmall(
                                      url: inActiveMatches[index]
                                          .matchedUser
                                          .imageUrls![0]),
                                ),
                                Text(
                                  inActiveMatches[index].matchedUser.name!,
                                  style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            );
                          }),
                        ),
                      ),
                      Text(
                        'Your Chats',
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      ListView.builder(
                        itemCount: activeMatches.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              chatScreen = false;
                              indexs = index;
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ChatScreen(userMatch: activeMatches[index]),
                              ));
                            },
                            child: Row(
                              children: [
                                UserImageSmall(
                                    url: activeMatches[index]
                                        .matchedUser
                                        .imageUrls![0]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      activeMatches[index].matchedUser.name!,
                                      style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      activeMatches[index]
                                          .chat![0]
                                          .messages[0]
                                          .message,
                                      style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      activeMatches[index]
                                          .chat![0]
                                          .messages[0]
                                          .timeString,
                                      style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class UserImageSmall extends StatelessWidget {
  const UserImageSmall({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: 90,
      width: 90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
