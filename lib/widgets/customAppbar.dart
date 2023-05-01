// ignore_for_file: prefer_const_constructors

import 'package:dating_app/screen/chat_screen.dart';
import 'package:dating_app/screen/matches_screen.dart';
import 'package:dating_app/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasAction;
  const CustomAppBar({Key? key, required this.title, this.hasAction = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void moveToProfileScreen() {
      Navigator.of(context).pushNamed(ProfileScreen.routeName);
    }

    void moveToChatScreen() {
      Navigator.of(context).pushNamed(MatchesScreen.routeName);
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Row(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              child: Image.asset(
                'images/fire.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.headline2,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
          ),
        ],
      ),
      actions: hasAction
          ? [
              IconButton(
                icon: Icon(
                  Icons.message,
                  color: Colors.deepPurple,
                ),
                onPressed: moveToChatScreen,
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.deepPurple,
                ),
                onPressed: moveToProfileScreen,
              ),
            ]
          : null,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);
}
