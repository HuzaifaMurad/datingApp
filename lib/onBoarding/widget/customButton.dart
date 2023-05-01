// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:dating_app/firebase/databaseRep.dart';
import 'package:dating_app/modal/modal.dart' as NewUser;
import 'package:dating_app/onBoarding/screens/onboarding_screen.dart';
import 'package:dating_app/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AuthServices.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;
  final TextEditingController? emailControler;
  final TextEditingController? passwordControler;
  bool newUser;
  CustomButton(
      {Key? key,
      required this.tabController,
      this.emailControler,
      this.passwordControler,
      required this.text,
      this.newUser = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authservices = Provider.of<AuthServies>(context);
    final dbrep = Provider.of<DataBaseRepository>(context);
    String? cid;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: newUser
            ? () async {
                NewUser.User? cUser = NewUser.User(
                    name: 'none',
                    age: 0,
                    gender: 'none',
                    imageUrls: [],
                    interests: [],
                    bio: 'none',
                    jobTitle: 'none',
                    location: 'none');
                await dbrep.createUser(cUser, authservices.userUid);
                dbrep.fetchuser();

                tabController.animateTo(tabController.index + 1);
              }
            : () async {
                if (emailControler != null && passwordControler != null) {
                  await authservices
                      .createUserwithEmailAndPassword(
                          emailControler!.text, passwordControler!.text)
                      .then(
                    (value) {
                      cid = authservices.userUid;
                      print('this is cid${cid}');
                    },
                  ).catchError(
                    (_) => print('Failed to add error'),
                  );
                }

                if (tabController.index == 6) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamed(HomeScreen.routeName);
                } else {
                  tabController.animateTo(tabController.index + 1);
                }
              },
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(text),
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent, elevation: 0.0),
      ),
    );
  }
}
