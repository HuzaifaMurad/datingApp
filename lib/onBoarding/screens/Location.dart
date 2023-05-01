// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/onBoarding/widget/customButton.dart';
import 'package:dating_app/onBoarding/widget/custom_text_field.dart';
import 'package:dating_app/onBoarding/widget/customtextheader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../firebase/databaseRep.dart';

class Location extends StatelessWidget {
  final TabController tabController;
  const Location({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final user = Provider.of<DataBaseRepository>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CustomTextHeader(
                  tabController: tabController,
                  title: 'What\'s Your Location?'),
              CustomTextField(
                tabController: tabController,
                title: 'Enter your Location',
                controller: controller,
                onchanged: (p0) {
                  user.nuser?.location = p0;
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.docId)
                      .update({
                    'location': user.nuser?.location,
                  });
                },
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 6,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).backgroundColor,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                tabController: tabController,
                text: 'Done',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
