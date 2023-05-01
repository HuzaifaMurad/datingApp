// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:dating_app/onBoarding/screens/Location.dart';
import 'package:dating_app/onBoarding/screens/bio_screen.dart';
import 'package:dating_app/onBoarding/screens/demo_screen.dart';
import 'package:dating_app/onBoarding/screens/email_verification.dart';
import 'package:dating_app/onBoarding/screens/pictures_screen.dart';
import 'package:dating_app/onBoarding/screens/start_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/widget.dart';
import 'email_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = '/bording-screen';
  const OnBoardingScreen({Key? key}) : super(key: key);

  static const List<Tab> tabs = [
    Tab(
      text: 'Start',
    ),
    Tab(
      text: 'Email',
    ),
    Tab(
      text: 'Email Verification',
    ),
    Tab(
      text: 'DemoGraphic',
    ),
    Tab(
      text: 'Pictures',
    ),
    Tab(
      text: 'Bio',
    ),
    Tab(
      text: 'Location',
    ),
  ];

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: OnBoardingScreen.tabs.length,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {}
          });
          return Scaffold(
            appBar: CustomAppBar(
              title: 'FIRE',
              hasAction: false,
            ),
            body: TabBarView(children: [
              Start(tabController: tabController),
              Email(tabController: tabController),
              EmailVerification(tabController: tabController),
              DemoGraphic(tabController: tabController),
              Pictures(tabController: tabController),
              Bio(tabController: tabController),
              Location(tabController: tabController)
            ]),
          );
        },
      ),
    );
  }
}
