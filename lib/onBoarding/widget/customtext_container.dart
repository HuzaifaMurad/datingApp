import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/firebase/databaseRep.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomTextController extends StatelessWidget {
  final TabController tabController;
  final String title;
  const CustomTextController(
      {Key? key, required this.tabController, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newUser = Provider.of<DataBaseRepository>(context).nuser;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 5),
        child: InkWell(
          splashColor: Colors.white54,
          onTap: () {
            newUser?.interests?.insert(0, title);
            FirebaseFirestore.instance
                .collection('users')
                .doc(newUser?.id)
                .update({
              'interests': newUser?.interests,
            });
          },
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.lato(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
