// ignore_for_file: prefer_const_constructors

import 'package:dating_app/modal/modal.dart';
import 'package:dating_app/modal/user.dart';
import 'package:dating_app/onBoarding/screens/onboarding_screen.dart';
import 'package:dating_app/screen/home_screen.dart';
import 'package:dating_app/screen/login_screen.dart';
import 'package:dating_app/screen/splash_screen1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/AuthServices.dart';

class Wrapper extends StatelessWidget {
  static const routeName = '/wraper';
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authservices = Provider.of<AuthServies>(context);
    return StreamBuilder<AuthUser?>(
      stream: authservices.user,
      builder: (context, AsyncSnapshot<AuthUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.active) {
          final AuthUser? user = snapshot.data;
          print('user email is : ${user?.email}');
          print('user uid is : ${user?.uid}');

          return user == null ? LoginScreen() : HomeScreen();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
