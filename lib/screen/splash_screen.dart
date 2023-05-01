import 'dart:async';

import 'package:dating_app/onBoarding/screens/onboarding_screen.dart';
import 'package:dating_app/onBoarding/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(
      Duration(seconds: 1),
      () => Navigator.of(context).pushNamed(Wrapper.routeName),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'images/fire.png',
                fit: BoxFit.cover,
                height: 100,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Love Fire',
              style: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.headline2,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
