// ignore_for_file: prefer_const_constructors

import 'package:dating_app/provider/AuthServices.dart';
import 'package:dating_app/screen/home_screen.dart';
import 'package:dating_app/widgets/customAppbar.dart';
import 'package:dating_app/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../onBoarding/screens/onboarding_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServies>(context);
    String? email;
    String? password;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'LOVE APP',
        hasAction: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (emails) {
                email = emails;
                print(emails);
              },
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (passwords) {
                password = passwords;
                print(passwords);
              },
              decoration: InputDecoration(
                  labelText: 'Password', prefixIcon: const Icon(Icons.lock)),
            ),
            SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
              title: 'LOGIN',
              onPressed: () async {
                await auth.signInwithEmailAndPassword(email!, password!);
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
                title: 'SiGNUP',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      OnBoardingScreen.routeName,
                      ModalRoute.withName('/bording-screen'));
                }),
          ],
        ),
      ),
    );
  }
}
