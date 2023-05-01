// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/firebase/databaseRep.dart';
import 'package:dating_app/onBoarding/widget/customButton.dart';
import 'package:dating_app/onBoarding/widget/custom_text_field.dart';
import 'package:dating_app/onBoarding/widget/customtext_container.dart';
import 'package:dating_app/onBoarding/widget/customtextheader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Bio extends StatelessWidget {
  final TabController tabController;
  const Bio({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final user = Provider.of<DataBaseRepository>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextHeader(
                    tabController: tabController,
                    title: 'Describe Your Self a Bit'),
                CustomTextField(
                  tabController: tabController,
                  title: 'Enter Your Bio',
                  controller: controller,
                  onchanged: (p0) {
                    user.nuser?.bio = p0;
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.docId)
                        .update({
                      'bio': user.nuser?.bio,
                    });
                  },
                ),
                SizedBox(
                  height: 100,
                ),
                CustomTextHeader(
                    tabController: tabController, title: 'What Do You Like?'),
                Row(
                  children: [
                    CustomTextController(
                        tabController: tabController, title: 'music'),
                    CustomTextController(
                        tabController: tabController, title: 'anime'),
                    CustomTextController(
                        tabController: tabController, title: 'sports'),
                  ],
                ),
                Row(
                  children: [
                    CustomTextController(
                        tabController: tabController, title: 'gym'),
                    CustomTextController(
                        tabController: tabController, title: 'books'),
                    CustomTextController(
                        tabController: tabController, title: 'dance'),
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
            ),
            Column(
              children: [
                StepProgressIndicator(
                  totalSteps: 6,
                  currentStep: 5,
                  selectedColor: Theme.of(context).primaryColor,
                  unselectedColor: Theme.of(context).backgroundColor,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  tabController: tabController,
                  text: 'Next Step',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
