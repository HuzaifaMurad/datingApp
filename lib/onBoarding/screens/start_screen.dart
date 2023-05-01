// ignore_for_file: prefer_const_constructors

import 'package:dating_app/onBoarding/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Start extends StatelessWidget {
  final TabController tabController;
  const Start({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset('images/couple.png'),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Welcome to Love Fire App',
                style: GoogleFonts.ubuntuCondensed(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
                style: GoogleFonts.ubuntuCondensed(
                    fontSize: 17, height: 1.5, color: Colors.deepPurple[300]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            tabController: tabController,
            text: 'Start',
          ),
        ),
      ],
    );
  }
}
